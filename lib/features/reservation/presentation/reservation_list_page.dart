import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/features/reservation/data/reservation_model.dart';
import 'package:salon_reservation/features/reservation/domain/reservation_repo.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_reservation/features/reservation/presentation/widget/reservation_card.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/helpers.dart';
import '../../../core/widget/base_page.dart';

class MyReservationsPage extends StatefulWidget {
  const MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        isCentered: false,
        title: 'reservations'.tr(),
        isScrollable: false,
        hasMenu: true,
        hasPadding: false,
        content:  Column(
          children: [
            Height.v2,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PaginationList<Reservation>(
                    repositoryCallBack: (data) =>
                        ReservationRepository.getReservations(
                          data,
                        ),
                    onCubitCreated: (cubit) {
                      //ServiceLocator.setAppointments(cubit!);
                    },
                    listBuilder: (list) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return ReservationCard(
                              reservation: list[index],
                            );
                          },
                          separatorBuilder: (context, _) {
                            return Height.v4;
                          },
                          itemCount: list.length
                      );
                    }
                ),
              ),
            ),
          ],
        ));
  }

}

class AppointmentCard extends StatelessWidget {
  final String? name;
  final String? specality;
  final VoidCallback? onTap;
  final String? image;

  AppointmentCard({this.name, this.specality, this.onTap, this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.white,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.darkerGray,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Image.asset(
                          image!,
                          height: 10.h,
                          width: 10.h,
                          fit: BoxFit.fill,
                        ),
                      ),
//                  SizedBox(
//                    width: 5.w,
//                  ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name!,
                              textAlign: TextAlign.justify,
                              style: AppStyles.title.copyWith(
                                  fontWeight: FontWeight.bold)),
                          Text(specality!,
                              textAlign: TextAlign.start,
                              style: AppStyles.body),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PopupMenuButton(
                        child: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Delete".tr()),
                            value: 1,
                          ),
                        ],
                        onSelected: (dynamic selection) {
                          switch (selection) {
                            case 1:
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text("are you sure?".tr()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("No".tr(),
                                              style: TextStyle(
                                                  color: AppColors.red)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes".tr(),
                                              style: TextStyle(
                                                  color: AppColors.red)),
                                        ),
                                      ],
                                    );
                                  });
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                height: 8.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        AppAssets.logo,
                        height: 6.w,
                        width: 6.w,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("الاثنين 26-1-2020"),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Image.asset(
                      AppAssets.logo,
                      height: 6.w,
                      width: 6.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text("11:00 - 12:00 صباحا"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),

              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     TextButton(
              //       style: TextButton.styleFrom(
              //         // primary: Colors.white,
              //         backgroundColor: AppColors.primary,
              //         //side: BorderSide(color: Colors.deepOrange, width: 1),
              //         elevation: 0,
              //         minimumSize: Size(42.5.w, 11.w),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         shadowColor: Colors.red,
              //       ),
              //       onPressed: () {},
              //       child: Text('تعديل',
              //           style: AppTheme.headline5
              //               .copyWith(color: AppColors.pureWhite)),
              //     ),
              //     OutlinedButton(
              //       onPressed: () {},
              //       child: Text("إلغاء",
              //           style: AppTheme.headline5
              //               .copyWith(color: AppColors.gray1)),
              //       style: TextButton.styleFrom(
              //         // primary: Colors.white,
              //         //backgroundColor: AppColors.primary,
              //         //side: BorderSide(color: Colors.deepOrange, width: 1),
              //         elevation: 0,
              //         minimumSize: Size(42.5.w, 11.w),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         shadowColor: Colors.red,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 4.h,
              // ),
              Container(
                height: 0.8.h,
                color: Color(0xFFE5E5E5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
