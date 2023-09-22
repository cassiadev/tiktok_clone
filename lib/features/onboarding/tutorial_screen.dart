import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

enum Direction {right, left}
enum Page {first, second}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _pageShowing = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // Move to the right
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // Move to the left
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _pageShowing = Page.second;
      });
    } else {
      setState(() {
        _pageShowing = Page.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate, // Swiping between components are called pan
      onPanEnd: _onPanEnd, // After the finger is off the screen
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade( // Puts in fade-in or fade-out effect between two compoments
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text('Watch cool videos!',
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v20,
                  Text('Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text('Follow the rules',
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v20,
                  Text('Please take care of one another.',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              crossFadeState: _pageShowing == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size24,),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _pageShowing == Page.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: const Text('Enter the App'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


