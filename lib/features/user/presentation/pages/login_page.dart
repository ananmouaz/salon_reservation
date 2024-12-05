import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/utils/navigation.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/core/widget/form/password_text_field.dart';
import 'package:salon_reservation/features/home/presentation/pages/main_page.dart';
import 'package:salon_reservation/features/user/data/model/login_request_model.dart';
import 'package:salon_reservation/features/user/data/model/login_response_model.dart';
import 'package:salon_reservation/features/user/domain/user_reposirory.dart';
import 'package:salon_reservation/features/user/presentation/pages/sign_up_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../../core/notification/domain/notification_repository.dart';
import '../../../../core/notification/notification_messaging.dart';
import '../../../../core/utils/di.dart';
import '../../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../../../core/validator.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/form/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late CreateModelCubit loginCubit;

  static final AppPreferences _appPreferences = instance<AppPreferences>();


  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasMenu: false,
      isCentered: true,
      title: 'login'.tr(),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('loginTitle'.tr() ,style: AppStyles.headline.copyWith(fontWeight: FontWeight.w600),),
            Height.v12,
            Row(
              children: [
     /*           SizedBox(
                  width: 80.w,
                  child: CustomTextField(
                    labelText: 'phoneCode'.tr(),
                    hintText: '+963',
                    keyboardType: TextInputType.phone,
                    controller: _codeController,
                    validator: (value) => Validator.validateEmptyWithoutMessage(value ?? ''),
                  ),
                ),
                Width.v12,*/
                Expanded(
                  child: CustomTextField(
                    labelText: 'phoneNumber'.tr(),
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumberController,
                    validator: (value) => Validator.validatePhoneNumber(value ?? ''),
                  ),
                ),
              ],
            ),
            Height.v16,
            PasswordTextField(
                controller: _passwordController,
                labelText: 'password'.tr(),
            ),
            Height.v16,
            CreateModel<LoginResponseModel>(
              onCubitCreated: (cubit) {
                loginCubit = cubit;
              },
              repositoryCallBack: (data) => UserRepository.login(data),
              onSuccess: (model) async{
                await LoginResponseModel.saveLoginToFile(model);
               // _appPreferences.setId(model.userId.toString());
                await NotificationRepository.updateFCMToken(
                    Messaging.token);
                Navigation.pushReplacement(context, const MainPage());
              },
              child: CustomButton(
                onTap: () {
                  if(_formKey.currentState!.validate()) {
                    loginCubit.createModel(LoginRequestModel(phoneNumber: _phoneNumberController.text, password: _passwordController.text));
                  }
                },
                text: 'login'.tr(),
              ),
            ),
            Height.v16,
            TextButton(
              onPressed: () {
                // Handle the "Don't have an account?" text button click here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: Text('registerSentence'.tr(), style: AppStyles.title,),
            ),
          ],
        ),
      ),
    );
  }
}
