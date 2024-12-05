import 'package:geolocator/geolocator.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salon_reservation/features/restaurant/presentation/pages/resraurants_page.dart';
import '../../../reservation/presentation/reservation_list_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.givenIndex});

  final int? givenIndex;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {




  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.givenIndex ?? 0;
    super.initState();
  }


  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          RestaurantsPage(),
          const MyReservationsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: AppStyles.body,
        unselectedLabelStyle: AppStyles.body,
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
        items:  [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/salon_active.svg',
                colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                width: 28.w,
                semanticsLabel: 'salons'.tr()
            ),
            icon: SvgPicture.asset(
                'assets/icons/salon_active.svg',
                width: 28.w,
                colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
                semanticsLabel: 'salons'.tr()
            ),
            label: 'salons'.tr(),
          ),

          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/salon_active.svg',
                colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                width: 28.w,
                semanticsLabel: 'restaurants'.tr()
            ),
            icon: SvgPicture.asset(
                'assets/icons/salon_active.svg',
                width: 28.w,
                colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
                semanticsLabel: 'restaurants'.tr()
            ),
            label: 'restaurants'.tr(),
          ),

          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/orders.svg',
                colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                semanticsLabel: 'reservations'
            ),
            icon: SvgPicture.asset(
                'assets/icons/orders.svg',
                colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
                semanticsLabel: 'reservations'
            ),
            label: 'reservations'.tr(),
          ),
        ],
      ),
    );
  }
}
