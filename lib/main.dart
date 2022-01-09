import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:sizer/sizer.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const OnBoardingScreen(),
        );
      },
    );
  }
}
