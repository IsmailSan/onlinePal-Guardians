import 'package:flutter/material.dart';
import 'package:online_pal_guardians/bloc/avatar_bloc/avatar_bloc.dart';
import 'package:online_pal_guardians/bloc/avatar_bloc/avatar_event.dart';
import 'package:online_pal_guardians/bloc/avatar_bloc/avatar_state.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_state.dart';
import 'package:online_pal_guardians/models/avatar/avatar_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class AvatarCollectionScreen extends StatefulWidget {
  final bool isUpdateProfile;
  final bool isParent;
  const AvatarCollectionScreen({
    Key? key,
    this.isUpdateProfile = false,
    this.isParent = true,
  }) : super(key: key);

  @override
  State<AvatarCollectionScreen> createState() => _AvatarCollectionScreenState();
}

class _AvatarCollectionScreenState extends State<AvatarCollectionScreen> {
  List<String> avatarImages = [];
  List<Avatar> avatars = [];
  String? selectedAvatar;
  int? selectedAvatarId;

  @override
  void initState() {
    super.initState();
    _loadGenderAndDispatchAvatarEvent();
  }

  void _loadGenderAndDispatchAvatarEvent() async {
    final savedGender = await SessionHelper().getGender();
    final savedChildGender = await SessionHelper().getChildGender();
    final profile = await SessionHelper().getChildProfile();

    final childGenderToUse = savedChildGender ?? '';
    final parentGenderToUse = savedGender ?? '';

    if (widget.isParent) {
      context.read<AvatarBloc>().add(GetAvatarList(gender: parentGenderToUse));
    } else {
      context.read<ChildProfileBloc>().add(GetChildAvatarList(gender: ''));
    }
    print("avatar nya ${widget.isParent}");
  }

  void _selectAvatar(String avatarPath, int avatarId) {
    setState(() {
      selectedAvatar = avatarPath;
      selectedAvatarId = avatarId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/mini_logo.png',
                          height: 30.h,
                        ),
                      ),
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
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.isParent == false
                        ? "Pilih Avatar Anak dari Koleksi Aplikasi"
                        : "Pilih Avatar dari Koleksi Aplikasi",
                    style: blackTextStyle.copyWith(
                        fontSize: 24.sp, fontWeight: regular),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  widget.isParent
                      ? BlocConsumer<AvatarBloc, AvatarState>(
                          listener: (context, state) {
                          if (state is AvatarError) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) =>
                                  ErrorDialog(message: state.message),
                            );
                          }
                          if (state is AvatarUpdateSuccess) {
                            if (widget.isUpdateProfile) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => SuccessDialog(
                                    message: 'Avatar Berhasil Diperbarui'),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AvatarCollectionScreen(
                                          isParent: false,
                                        )),
                              );
                            }
                          }
                        }, builder: (context, state) {
                          if (state is AvatarListSuccess) {
                            avatars = state.response.data;
                            avatarImages = avatars
                                .map((a) => a.imageUrl)
                                .whereType<String>()
                                .toList();
                            selectedAvatar ??= avatarImages.isNotEmpty
                                ? avatarImages[0]
                                : null;
                          }
                          return _buildAvatarContent();
                        })
                      : BlocConsumer<ChildProfileBloc, ChildProfileState>(
                          listener: (context, state) {
                          if (state is ChildAvatarError) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) =>
                                  ErrorDialog(message: state.message),
                            );
                          }
                          if (state is ChildAvatarUpdateSuccess) {
                            if (widget.isUpdateProfile) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => SuccessDialog(
                                    message: 'Avatar Anak Berhasil Diperbarui'),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()),
                              );
                            }
                          }
                        }, builder: (context, state) {
                          if (state is ChildAvatarListSuccess) {
                            avatars = state.response.data;
                            avatarImages = avatars
                                .map((a) => a.imageUrl)
                                .whereType<String>()
                                .toList();
                            selectedAvatar ??= avatarImages.isNotEmpty
                                ? avatarImages[0]
                                : null;
                          }
                          return _buildAvatarContent();
                        }),
                  if (avatarImages.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: (selectedAvatar == null)
                              ? null
                              : () async {
                                  final profile =
                                      await SessionHelper().getChildProfile();
                                  final registeredProfileId =
                                      await SessionHelper().getProfileId();
                                  final childProfileId =
                                      profile?.id ?? registeredProfileId;
                                  print(
                                      "child profile id $registeredProfileId");
                                  widget.isParent
                                      ? context.read<AvatarBloc>().add(
                                          UpdateAvatar(
                                              avatarId: selectedAvatarId ?? 0))
                                      : context.read<ChildProfileBloc>().add(
                                          UpdateChildAvatar(
                                              avatarId: selectedAvatarId ?? 0,
                                              childProfileId:
                                                  childProfileId ?? 0));
                                },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            widget.isParent
                                ? 'Pilih sebagai avatar saya'
                                : 'Pilih sebagai avatar anak saya',
                            style: blackTextStyle.copyWith(
                                fontSize: 20.sp, fontWeight: bold),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            BlocBuilder<AvatarBloc, AvatarState>(
              builder: (context, state) {
                if (state is AvatarLoading || state is ChildProfileLoading) {
                  return Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const LoadingDialog(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarContent() {
    return Expanded(
      child: avatarImages.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/no_data.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Avatar tidak tersedia',
                    style: blackTextStyle.copyWith(
                        fontSize: 16.sp, fontWeight: bold),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                if (selectedAvatar != null)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD9D9D9), Color(0xFF737373)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        selectedAvatar!,
                        width: 150.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: avatarImages.length,
                    itemBuilder: (context, index) {
                      final avatar = avatars[index];
                      return GestureDetector(
                        onTap: () =>
                            _selectAvatar(avatar.imageUrl ?? "", avatar.id),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFD9D9D9), Color(0xFF737373)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              avatarImages[index],
                              width: 150.w,
                              height: 150.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
