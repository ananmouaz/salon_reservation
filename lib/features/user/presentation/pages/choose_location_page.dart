import 'package:salon_reservation/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/utils/navigation.dart';
import 'package:salon_reservation/core/utils/toast.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/features/user/data/model/register_request_model.dart';
import 'package:salon_reservation/features/user/data/model/register_response_model.dart';
import 'package:salon_reservation/features/user/domain/user_reposirory.dart';
import 'package:salon_reservation/features/user/presentation/pages/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/form/custom_text_field.dart';
import '../../data/model/user_model.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key, required this.user});

  final UserModel user;

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  late CreateModelCubit registerCubit;
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      title: 'chooseLocation'.tr(),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            // Add your map integration here
            CreateModel<RegisterResponseModel>(
              repositoryCallBack: (data) => UserRepository.register(data),
              onCubitCreated: (cubit) {
                registerCubit = cubit;
              },
              onSuccess: (model) {
                Toasts.show(context, 'createdUser'.tr(), ToastType.success);
                Future.delayed(const Duration(seconds: 2), () {
                  Navigation.pushReplacement(context, const LoginPage());
                });
              },
              child: CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    registerCubit.createModel(RegisterRequestModel(
                        user: widget.user,
                        ));
                  }
                },
                text: 'continue'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
