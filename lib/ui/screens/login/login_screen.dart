import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/login_bloc/login_bloc.dart';
import 'package:online_pal_guardians/bloc/login_bloc/login_event.dart';
import 'package:online_pal_guardians/bloc/login_bloc/login_state.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/main_screen.dart';
import 'package:online_pal_guardians/ui/screens/welcome_page.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/utils/globals.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  String? selectedProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 24, left: 24, top: 10, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const WelcomeScreen()));
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.arrow_back_ios, size: 18.0),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'KEMBALI',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 17.sp, fontWeight: regular),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'MASUK',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 27.sp, fontWeight: bold),
                                  ),
                                  SizedBox(height: 20.h),
                                  Image.asset(
                                    'assets/logo_onlinepal_guardians.png',
                                    width: 200.w,
                                    height: 235.h,
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            CustomFormField(
                              label: 'USERNAME',
                              hintText: '',
                              controller: userNameController,
                              focusNode: usernameFocusNode,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Username wajib diisi';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15.h),
                            CustomFormField(
                              label: 'PASSWORD',
                              hintText: '',
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              isPassword: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Password wajib diisi';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 70.h),
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen(key: mainScreenKey,)),
                                  );
                                } else if (state is LoginError) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => ErrorDialog(message: state.message),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => MainScreen(key: mainScreenKey,)),
                                      // );

                                      if (_formKey.currentState?.validate() != true) {
                                        return;
                                      }
                                      final userName =
                                          userNameController.text.trim();
                                      final password =
                                          passwordController.text.trim();

                                      if (userName.isNotEmpty &&
                                          password.isNotEmpty) {
                                        context.read<LoginBloc>().add(
                                              LoginButtonPressed(
                                                  username: userName,
                                                  password: password,
                                                  role: 'parent'),
                                            );
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Colors.black),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Login',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 20.sp, fontWeight: bold),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/main_bottom.png',
                          fit: BoxFit.cover,
                          height: 110.h,
                          width: 500.w,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return Container(
                        child: const LoadingDialog(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
