import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();
  final _scrollDuration = const Duration(milliseconds: 200);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int pageNum) {
    _pageController.animateToPage(
        pageNum,
        duration: _scrollDuration,
        curve: _scrollCurve,
    );
    if (pageNum == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    };
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      pageSnapping: true, // If pageSnapping is set false, the sticky page snap does not happen as moving the page. Default is true
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      controller: _pageController,
      itemCount: _itemCount,
      itemBuilder: (context, index) => VideoPost(
        onVideoFinished: _onVideoFinished
      ),
    );
  }
}
