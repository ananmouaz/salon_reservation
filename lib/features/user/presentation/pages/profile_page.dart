import 'package:salon_reservation/core/api/core_models/base_result_model.dart';
import 'package:salon_reservation/core/widget/loading_widget.dart';
import 'package:salon_reservation/features/user/domain/user_reposirory.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/helpers.dart';
import '../../../../core/formatters.dart';
import '../../../../core/validator.dart';
import '../../../../core/widget/base_page.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/form/custom_text_field.dart';
import '../../data/model/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool isLoading = true;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    BaseResultModel? res = await UserRepository.getUserInfo();
    if(res is UserGetModel) {
      _phoneNumberController.text = res.user?.phoneNumber ?? '';
    }
    setState(() {
      isLoading = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      isCentered: isLoading ? true : false,
      title: 'personalProfile'.tr(),
      content: isLoading ?
      const LoadingWidget() :
      Form(
        key: _formKey,
        child: Column(
          children: [
            Height.v16,
            CustomTextField(
              labelText: 'Name'.tr(),
              controller: _clinicNameController,
              validator: (value) =>
                  Validator.validateEmpty(value ?? '', 'pharmacyName'.tr()),
            ),
            Height.v16,
            CustomTextField(
              textInputAction: TextInputAction.done,
              labelText: 'phoneNumber'.tr(),
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              validator: (value) => Validator.validatePhoneNumber(value ?? ''),
            ),
            Height.v16,
            GestureDetector(
              onTap: () {
                _showDatePicker(context);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: CustomTextField(
                  labelText: 'dateOfBirth'.tr(),
                  controller: _dateOfBirthController,
                  hintText: 'selectDateOfBirth'.tr(),
                  validator: (value) =>
                      Validator.validateEmpty(value ?? '', 'dateOfBirth'.tr()),
                ),
              ),
            ),
            Height.v16,
            CustomTextField(
              labelText: 'area'.tr(),
              controller: _areaController,
            ),
            Height.v16,
            CustomTextField(
              labelText: 'street'.tr(),
              controller: _streetController,
            ),
            Height.v16,
            CustomTextField(
              labelText: 'building'.tr(),
              controller: _buildingController,
            ),
            Height.v16,
            CustomButton(
              text: 'save'.tr(),
              onTap: () {
                if (_formKey.currentState!.validate()) {

                }
              },
            ),
          ],
        ),
      )
    );
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            backgroundColor: Colors.white,
            initialDateTime: _selectedDate,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
                _dateOfBirthController.text = Formatters.formatDate(newDate);
              });
            },
          ),
        );
      },
    );
  }
}