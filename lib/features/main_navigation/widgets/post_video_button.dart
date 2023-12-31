import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    super.key,
    required this.isInverted,
  });

  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Does not clip the supposed-to-be clipped one
      children: [
        Positioned( // Moves the widget surrounded
          right: 20,
          child: Container(
            height: 35,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            height: 35,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color:Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          decoration: BoxDecoration(
            color: isInverted? Colors.black: Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size6),
          ),
          child: Center(
            child: FaIcon(FontAwesomeIcons.plus,
              color: isInverted? Colors.white: Colors.black,
              size: Sizes.size16 + Sizes.size2,
            ),
          ),
        ),
      ],
    );
  }
}
