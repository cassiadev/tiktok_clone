import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int pageNum) {
    _pageController.animateToPage(
        pageNum,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear
    );
    if (pageNum == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.blueAccent,
        Colors.pink,
        Colors.amber,
        Colors.green,
      ]);
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      pageSnapping: true, // If pageSnapping is set false, the sticky page snap does not happen as moving the page. Default is true
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      controller: _pageController,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container( // itemBuilder of PageView.builder is similar to or could be same as ListView.builder, as it takes context and index as arguments
        color: colors.elementAt(index),
        child: Center(
          child: Text("Screen $index",
            style: const TextStyle(
              fontSize: 68,
            ),
          ),
        ),
      ),
    );
  }
}
