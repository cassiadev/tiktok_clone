import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class AuthButton extends StatelessWidget {

  final String text;

  const AuthButton({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox( // FractionallySizedBox decides the size of a box relative to its parent using widthFactor
      widthFactor: 1,
       child: Container(
         padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ),
        ),
        child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
