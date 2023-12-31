import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/sizes.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished; // Declare onVideoFinished right down the StatefulWidget, not in the State so that VideoTimelineScreen can put in its private function in its build()
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> with SingleTickerProviderStateMixin { // Added mixin for the AnimationController to make a ticker(which ticks at every frame of the animation) enabled just when the widget is displayed // By with keyword you can bring all the elements of a class with out extending it
  late final VideoPlayerController _videoPlayerController;
  bool _isPaused = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;
  bool _isSeeingMore = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration == _videoPlayerController.value.position) { // videoPlayerController.value.position means current duration of the video playing
        widget.onVideoFinished(); // Lets State have an access to property of StetefulWidget by the keyword "widget."
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1
        && !_isPaused
        && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset('assets/videos/20231001_181736.mp4');
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _onSeeMoreTap() {
    setState(() {
      _isSeeingMore = !_isSeeingMore;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) _onTogglePause();
    await showModalBottomSheet(
      context: context,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Enables changing the size of the modal bottom sheet, Should be true when used in ListView or GridView
    );
    _onTogglePause();
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this, // Prevents offscreen animations from consuming unnecessary resources, with adding SingleTickerProviderStateMixin to the class definition
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5, // default value
      duration: _animationDuration,
    );

  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
          ),
          Positioned.fill(
            child: GestureDetector (
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill( // Positioned widget had better be the child right down to Stack always, not the child of IgnorePointer or else whatever
            child: IgnorePointer( // Ignores the click event of the FaIcon
              child: Center (
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child, // The one with AnimatedOpacity down below
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('@IMyMeMY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                SizedBox(
                  width: Sizes.size96 + Sizes.size96 + Sizes.size20,
                  child: GestureDetector(
                    onTap: _onSeeMoreTap,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text('This is my text and you know what I am going to develop is a massive app',
                            maxLines: _isSeeingMore ? 10 : 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.symmetric(horizontal: Sizes.size2),
                          child: Text(
                            _isSeeingMore ? "" : "See more",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: Sizes.size14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage('https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/0722-0-21-1659275415.jpg?crop=1.00xw:0.753xh;0,0.0336xh&resize=980:*'),
                  child: Text('IMyMeMy',
                  ),
                ),
                Gaps.v28,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: '2.9M',
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidCommentDots,
                    text: '33K',
                  ),
                ),
                Gaps.v28,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: 'Share',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
