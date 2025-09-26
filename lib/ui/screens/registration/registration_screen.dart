import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/registration_bloc/registration_bloc.dart';
import 'package:online_pal_guardians/bloc/registration_bloc/registration_event.dart';
import 'package:online_pal_guardians/bloc/registration_bloc/registration_state.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/profile/create_profile_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/guardian_profile_screen.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final passwordConfirmationController = TextEditingController(text: '');
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordConfirmationFocusNode = FocusNode();

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
                                Navigator.pop(context);
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
                                    'Daftar',
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
                              label: 'Username',
                              hintText: '',
                              controller: userNameController,
                              focusNode: usernameFocusNode,
                              helperText:
                                  'Nama pengguna harus unik dan mengandung minimal 8 karakter tanpa spasi.',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Username wajib diisi';
                                } else if (val.length < 8) {
                                  return 'Username minimal 8 karakter';
                                } else if (val.contains(' ')) {
                                  return 'Username tidak boleh mengandung spasi';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15.h),
                            CustomFormField(
                              label: 'Password',
                              hintText: '',
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              helperText:
                                  'Password harus terdiri dari minimal 8 karakter dengan setidaknya satu huruf dan satu angka.',
                              isPassword: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Password wajib diisi';
                                } else if (val.length < 8) {
                                  return 'Password minimal 8 karakter';
                                } else if (!RegExp(
                                        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$')
                                    .hasMatch(val)) {
                                  return 'Password wajib mengandung huruf dan angka';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15.h),
                            CustomFormField(
                              label: 'Konfirmasi Password',
                              hintText: '',
                              controller: passwordConfirmationController,
                              focusNode: passwordConfirmationFocusNode,
                              isPassword: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Konfirmasi password wajib diisi';
                                } else if (val != passwordController.text) {
                                  return 'Konfirmasi password tidak cocok';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 70.h),
                            BlocConsumer<RegistrationBloc, RegistrationState>(
                              listener: (context, state) {
                                if (state is RegistrationSuccess) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const CreateProfileScreen()),
                                  );
                                } else if (state is RegistrationError) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) =>
                                        ErrorDialog(message: state.message),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: state is RegistrationLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState
                                                    ?.validate() !=
                                                true) {
                                              return;
                                            }
                                            final userName =
                                                userNameController.text.trim();
                                            final password =
                                                passwordController.text.trim();
                                            final passwordConfirmation =
                                                passwordConfirmationController
                                                    .text
                                                    .trim();

                                            context
                                                .read<RegistrationBloc>()
                                                .add(
                                                  RegistrationButtonPressed(
                                                    userName: userName,
                                                    password: password,
                                                    passwordConfirmation:
                                                        passwordConfirmation,
                                                  ),
                                                );
                                          },
                                    style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.black),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Simpan',
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
                    ],
                  ),
                ),
                BlocBuilder<RegistrationBloc, RegistrationState>(
                  builder: (context, state) {
                    if (state is RegistrationLoading) {
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
