import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

import 'constants/sizes.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primaryColor: const Color(0xFFE9435A),
      //   scaffoldBackgroundColor: Colors.white,
      //   appBarTheme: const AppBarTheme(
      //     foregroundColor: Colors.black,
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     titleTextStyle: TextStyle(
      //       color: Colors.black,
      //       fontSize: Sizes.size16 + Sizes.size2,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),
      home: const MainNavigationScreen(),
    );
  }
}
