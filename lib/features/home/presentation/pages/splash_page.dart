import 'dart:async';

import 'package:salon_reservation/features/home/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/helpers.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  // duration of splash screen on second
  int splashTime = 4;

  @override
  void initState() {
      Future.delayed(Duration(seconds: splashTime), () async {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            }));
      });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 400.h,
                  height: 400.h,
                  child:  Lottie.asset(
                      AppAssets.logoJson,
                      repeat: false,
                      height: 150.h
                  ),),
              Height.v12,
              Text(Constants.APP_NAME, style: AppStyles.headline,)
            ],
          ) //AppLogo(),
        )
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key, this.height, this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: height ?? 450.w,
        height: width ?? 400.h,
        child: const Image(image: AssetImage(AppAssets.logo)));
  }
}
