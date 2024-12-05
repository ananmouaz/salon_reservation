/*
import 'package:clinic_patients/core/utils/Converters/Converters.dart';
import 'package:clinic_patients/features/HealthcareCenter/data/HealthCareCenterListResponse.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import '../../../../core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/utils/ServiceLocator/ServiceLocator.dart';
import '../../../../core/widgets/CustomButtonLebeld.dart';
import '../../../../core/widgets/appbar/InnerAppBar.dart';
import '../../../../core/widgets/snackbar.dart';
import '../../../App/presentation/pages/Homepage.dart';
import '../../../Doctor/data/DoctorListResponseModel.dart';
import '../../../PatientProfile/data/PatientCardListResponse.dart';
import '../../data/CreateAppointmentRequestModel.dart';
import '../../data/CreateAppointmentResponseModel.dart';
import '../../data/DoctorShiftResponseModel.dart';
import '../../domain/repo/AppointmentRepository.dart';

class AppointmentConfirmationPage extends StatelessWidget {
  AppointmentConfirmationPage({Key? key, this.patient, this.center, this.doctor, this.date, this.time, this.shift, this.isVirtual}) : super(key: key);

  final PatientCard? patient;
  final HealthCareCenter? center;
  final Doctor? doctor;
  final DateTime? date;
  final DateTime? time;
  final DoctorShiftInterval? shift;
  final bool? isVirtual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
        Container(
          padding: AppStyles.allPadding,
          margin: EdgeInsets.only(bottom: 30),
          child: CreateModel<CreateAppointmentResponseModel>(
            repositoryCallBack: (data) =>
                AppointmentRepository.createAppointment(data),
            onCubitCreated: (CreateModelCubit? c) {
              cubit = c!;
            },
            onSuccess: (CreateAppointmentResponseModel model) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeApp()), (Route<dynamic> route) => false);
                showSnackBar('Created'.tr(), context);
            },
            child: CustomButtonLabeled(
              isActive: true,
              onPressed: () {
                cubit.createModel(
                  CreateAppointmentRequestModel(
                    doctorId: doctor!.id,
                    patientId: patient!.id,
                    type: shift!.type,
                    appointmentDate: date,
                    endTime: time,
                    startTime: time,
                    doctorShiftId: shift!.doctorShiftId,
                    healthCareCenterId: isVirtual! ? null : center!.id,
                  ),
                );
              },
              color: isVirtual! ? AppColors.onlineButton : AppColors.primary.withOpacity(0.8),
              text: "Confirm".tr(),
              icon: Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
      appBar: InnerAppBar(
        title: 'Reserve an appointment'.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Confirm Info'.tr(),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 30,),

              // Doctor Row
              Row(
                children: [
                  IconCard(icon: Icons.local_hospital_rounded, isVirtual: isVirtual),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          AppStyles.cardShadow

                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor!.fullName!,
                            style: AppTheme.subtitle2,
                          ),
                          isVirtual! ? SizedBox.shrink() :
                          Text(
                              center!.name!,
                            style: AppTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20,),

              // Time and date Row
              Row(
                children: [
                  IconCard(icon: Icons.calendar_month_rounded, isVirtual: isVirtual),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            AppStyles.cardShadow

                          ]
                      ),
                      child: Text(
                          "${date!.day.toString()}/${date!.month.toString()}/${date!.year.toString()}"
                      ),
                    ),
                  ),

                  SizedBox(width: 20,),

                  IconCard(icon: Icons.access_time_outlined,isVirtual: isVirtual),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            AppStyles.cardShadow

                          ]
                      ),
                      child: Text(
                          MyConverter.getTime(time!)
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20,),

              // Patient Row
              Row(
                children: [
                  IconCard(icon: Icons.person, isVirtual: isVirtual),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            AppStyles.cardShadow

                          ]
                      ),
                      child: Text(
                          "${"Patient Name".tr()}: ${patient!.name}"
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20,),




            ],
          ),
        ),
      ),

    );
  }
}

late CreateModelCubit cubit;



class IconCard extends StatelessWidget {
  const IconCard({
    Key? key, this.icon, this.isVirtual = false,
  }) : super(key: key);

  final IconData? icon;
  final bool? isVirtual;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: isVirtual! ? AppColors.onlineButton : AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.pureWhite,),
    );
  }
}
*/
