import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loading();
  }

  void loading() async {
    await Future.delayed(const Duration(seconds: 2));
    // Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.heightOf(context);
    final double width = MediaQuery.widthOf(context);
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/app_logo.png', fit: BoxFit.cover),
            Positioned(
              top: height / 2 + 90,
              left: width / 2 - 15,
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}
