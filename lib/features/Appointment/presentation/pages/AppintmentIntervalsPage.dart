import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/utils/toast.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/core/widget/custom_button.dart';
import 'package:salon_reservation/features/reservation/domain/reservation_repo.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/api/core_models/message_response_model.dart';
import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/boilerplate/get_model/cubits/get_model_cubit.dart';
import '../../../../core/boilerplate/get_model/widgets/get_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/utils/di.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../../home/presentation/pages/main_page.dart';
import '../../../reservation/data/booking_request_model.dart';
import '../../../reservation/data/salon_times_response_model.dart';


class AppointmentIntervalsPage extends StatefulWidget {
  const AppointmentIntervalsPage(
      {Key? key, required this.businessId, required this.serviceId})
      : super(key: key);

  final String businessId;
  final String serviceId;

  @override
  State<AppointmentIntervalsPage> createState() =>
      _AppointmentIntervalsPageState();
}

class _AppointmentIntervalsPageState extends State<AppointmentIntervalsPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String? _selectedTime;

  late CreateModelCubit bookingCubit;
  late GetModelCubit intervalCubit;


  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      title: 'appointmentReservation'.tr(),
      bottomNavigationBar:
      Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: CreateModel<MessageResponseModel>(
          onCubitCreated: (cubit) {
            bookingCubit = cubit;
          },
          repositoryCallBack: (data) => ReservationRepository.addBooking(data),
          onSuccess: (model) async{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('bookedSuccessfully'.tr(), style: AppStyles.body,),
                backgroundColor: AppColors.green,
              ),
            );
            Navigation.pushReplacement(context, const MainPage(givenIndex: 1,));
          },
          child: CustomButton(
            enabled: _selectedDay != null ? true : false,
            onTap: () {
              bookingCubit.createModel(BookingRequestModel(businessId: int.parse(widget.businessId), serviceId: int.parse(widget.serviceId), time: formatDatetime(DateFormat('yyyy-MM-dd').format(_selectedDay), _selectedTime ?? '')));
            },
            text: "reserve".tr(),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getCalendarTable(),

                Height.v12,

                if (_selectedDay != null)
                  Text('appointmentTime'.tr(), style: AppStyles.title),
                Height.v12,
              ],
            ),

            if (_selectedDay != null) _buildInterval(),
          ],
        ),
      ),
    );
  }

  final AppPreferences _appPreferences = instance<AppPreferences>();

  Container _getCalendarTable() {
    return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TableCalendar(
              locale: _appPreferences.getLanguage(),
              daysOfWeekHeight: 30,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 13),
                weekendStyle: TextStyle(fontSize: 13),
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false
              ),
              calendarStyle: CalendarStyle(
                outsideTextStyle: const TextStyle(color: Colors.black),
                todayDecoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.5),
                    shape: BoxShape.circle
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle
                ),
              ),
              firstDay: DateTime.now(),
              lastDay: DateTime((DateTime.now().year) + 1),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) async{
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                await intervalCubit.getModel();
              },
            ),
          );
  }

  Widget _buildInterval() {
    return GetModel<SalonTimesResponseModel>(
        onCubitCreated: (cubit) {
          intervalCubit = cubit!;
        },
        repositoryCallBack: (data) => ReservationRepository.getTimesOfDay(
          widget.serviceId,
          _selectedDay.toString(),
        ),
        modelBuilder: (data) => buildIntervalList(data.items!),
      );
  }
  int? selectedIndex;


  Widget buildIntervalList(List<SalonTimeModel> list) {
    if(list.isEmpty) {
      return Container(
          margin: const EdgeInsets.only(right: 20),
          child: Text('noAppointments'.tr(), style: AppStyles.title,).tr(),);
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: ListView.separated(
              separatorBuilder: (context, _) {
                return Width.v8;
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return intervalCard(index, list);
              },
              itemCount: list.length,
            ),
          ),
          Height.v12,
          if(_selectedTime != null)
          Text('selectedAppointment'.tr(), style: AppStyles.title,),
          Height.v8,
          if(_selectedTime != null)
          Text(combineDateAndTime(_focusedDay.toString(), _selectedTime ?? '').toString(), style: AppStyles.headline.copyWith(fontWeight: FontWeight.w600),)
        ],
      );
    }

  }

  DateTime formatDatetime(String date, String time) {
    // Parse date and time strings into DateTime objects
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    DateTime parsedTime = DateFormat('HH:mm').parse(time);

    // Combine date and time
    DateTime adjustedDate = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    return adjustedDate;
  }

  String combineDateAndTime(String date, String time) {
    // Parse date and time strings into DateTime objects
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    DateTime parsedTime = DateFormat('HH:mm').parse(time);

    // Combine date and time
    DateTime adjustedDate = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );

    var outputFormat = DateFormat('dd-MM-yyyy | hh:mm a');
    var outputDate = outputFormat.format(adjustedDate);

    return outputDate.toString();
  }

  InkWell intervalCard(int index, List<SalonTimeModel> list) {
    return InkWell(
      highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  _selectedTime = list[index].time ?? '';
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: selectedIndex == index ? AppColors.primary : null,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: selectedIndex == index ?  AppColors.secondary  : AppColors.black),
                ),
                child: Text(
                  list[index].time ?? '',
                  style: AppStyles.title.copyWith(
                      color:  selectedIndex == index ? AppColors.secondary : AppColors.black
                  ),
                ),
              )
          );
  }
}
