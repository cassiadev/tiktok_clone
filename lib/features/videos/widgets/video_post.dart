import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class _VideoPostState extends State<VideoPost> with SingleTickerProviderStateMixin{ // Added mixin for the AnimationController to make a ticker(which ticks at every frame of the animation) enabled just when the widget is displayed // By with keyword you can bring all the elements of a class with out extending it
  final VideoPlayerController _videoPlayerController = VideoPlayerController.asset('assets/videos/20231001_181736.mp4');
  bool _isPaused = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration == _videoPlayerController.value.position) { // videoPlayerController.value.position means current duration of the video playing
        widget.onVideoFinished(); // Let State have an access to property of StetefulWidget by the keyword "widget."
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
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
    await _videoPlayerController.initialize();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
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
        ],
      ),
    );
  }
}
