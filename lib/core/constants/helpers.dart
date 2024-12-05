import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ExtendedWidget on Widget {
  respectGuidelinesMargins({bool left = true, bool right = true}) {
    return Container(
      margin: EdgeInsets.only(
        left: left ? 20 : 0,
        right: right ? 20 : 0,
      ),
      child: this,
    );
  }
}

abstract class Guides {
  static double v2 = 2.0.h;
  static double v4 = 4.0.h;
  static double v8 = 8.0.h;
  static double v10 = 10.0.h;
  static double v12 = 12.0.h;
  static double v16 = 16.0.h;
  static double v20 = 20.0.h;
  static double v24 = 24.0.h;
  static double v28 = 28.0.h;
  static double v32 = 32.0.h;
  static double v40 = 40.0.h;
  static double v48 = 48.0.h;
  static double v64 = 64.0.h;
}

class Height extends SizedBox {
  static Widget nothing = const SizedBox();
  static Widget v2 = SizedBox(height: Guides.v2);
  static Widget v4 = SizedBox(height: Guides.v4);
  static Widget v8 = SizedBox(height: Guides.v8);
  static Widget v12 = SizedBox(height: Guides.v12);
  static Widget v16 = SizedBox(height: Guides.v16);
  static Widget v20 = SizedBox(height: Guides.v20);
  static Widget v24 = SizedBox(height: Guides.v24);
  static Widget v28 = SizedBox(height: Guides.v28);
  static Widget v32 = SizedBox(height: Guides.v32);
  static Widget v48 = SizedBox(height: Guides.v48);
  static Widget v64 = SizedBox(height: Guides.v64);

  const Height({Key? key}) : super(key: key);
}

class Width extends SizedBox {
  static Widget v2 = SizedBox(width: Guides.v2);
  static Widget v4 = SizedBox(width: Guides.v4);
  static Widget v8 = SizedBox(width: Guides.v8);
  static Widget v10 = SizedBox(width: Guides.v10);
  static Widget v12 = SizedBox(width: Guides.v12);
  static Widget v16 = SizedBox(width: Guides.v16);
  static Widget v20 = SizedBox(width: Guides.v20);
  static Widget v24 = SizedBox(width: Guides.v24);
  static Widget v32 = SizedBox(width: Guides.v32);
  static Widget v64 = SizedBox(width: Guides.v64);

  const Width({Key? key}) : super(key: key);
}