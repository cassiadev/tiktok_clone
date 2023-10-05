import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
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
    return;
    _pageController.nextPage( // No more auto next page in real TikTok reportedly
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 3)); // onRefresh() must return a Future
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 40,
      edgeOffset: 10,
      color: Theme.of(context).primaryColor,
      strokeWidth: Sizes.size3,
      child: PageView.builder(
        pageSnapping: true, // If pageSnapping is set false, the sticky page snap does not happen as moving the page. Default is true
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        controller: _pageController,
        itemCount: _itemCount,
        itemBuilder: (context, index) => VideoPost(
          onVideoFinished: _onVideoFinished,
          index: index,
        ),
      ),
    );
  }
}
