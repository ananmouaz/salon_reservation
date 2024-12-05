import 'package:salon_reservation/core/api/core_models/message_response_model.dart';
import 'package:salon_reservation/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:salon_reservation/core/utils/navigation.dart';
import 'package:salon_reservation/core/utils/toast.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/features/user/domain/user_reposirory.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/helpers.dart';
import '../../../../core/validator.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/form/custom_text_field.dart';
import '../../../../core/widget/form/password_text_field.dart';
import '../../data/model/register_request_model.dart';
import '../../data/model/user_model.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late CreateModelCubit registerCubit;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      isCentered: true,
      title: 'register'.tr(),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              labelText: 'name'.tr(),
              controller: _nameController,
              validator: (value) =>
                  Validator.validateEmpty(value ?? '', 'name'.tr()),
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
            PasswordTextField(
              controller: _passwordController,
              labelText: 'password'.tr(),
            ),
            Height.v16,
            CreateModel<MessageResponseModel>(
              repositoryCallBack: (data) => UserRepository.register(data),
              onCubitCreated: (cubit) {
                registerCubit = cubit;
              },
              onSuccess: (model) async{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(model.message ?? '', style: AppStyles.body,),
                    backgroundColor: AppColors.green,
                  ),
                );
                Navigation.pushReplacement(context, const LoginPage());
              },
              onFailure: () {
                Toasts.show(context, 'Failed', ToastType.error);
              },
              child: CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    registerCubit.createModel(RegisterRequestModel(
                      user: UserModel(
                        name: _nameController.text,
                        phoneNumber: _phoneNumberController.text,
                        password: _passwordController.text,
                      ),
                    ));
                  }
                },
                text: 'register'.tr(),
              ),
            ),
            Height.v16,
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text(
                'loginSentence'.tr(),
                style: AppStyles.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
