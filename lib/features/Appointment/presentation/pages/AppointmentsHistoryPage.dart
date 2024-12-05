/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/Boilerplate/Pagination/widgets/PaginationList.dart';
import '../../../../core/utils/ServiceLocator/ServiceLocator.dart';
import '../../../../core/widgets/appbar/InnerAppBar.dart';
import '../../../../core/widgets/errors/NoDataWidget.dart';
import '../../data/AppointmentListResponse.dart';
import '../../domain/repo/AppointmentRepository.dart';
import '../widgets/AppointmentsListWidget.dart';

class AppointmentHistoryPage extends StatefulWidget {
  const AppointmentHistoryPage({Key? key}) : super(key: key);

  @override
  State<AppointmentHistoryPage> createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: InnerAppBar(
          title: "Appointments History".tr(),
        ),
        body: _getBodyWidget());
  }

  Container _getBodyWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:
            // Upcoming list of appointments
            PaginationList<Appointment>(
              repositoryCallBack: (data) =>
                  AppointmentRepository.getAppointments(
                    data,
                    "true",
                  ),
              onCubitCreated: (cubit) {
                ServiceLocator.setAppointments(cubit!);
              },
              listBuilder: (list) => list.isNotEmpty
                  ? _getUpcomingAppointments(list)
                  : Align(
                  alignment: Alignment.bottomCenter, child: NoDataWidget()),
            ),
          ),
        ],
      ),
    );
  }

  ListView _getUpcomingAppointments(list) {
    return ListView(
        children: List.generate(
            list.length,
                (index) => AppointmentListCard(
                  active: false,
              appointment: list[index],
            )));
  }
}
*/
