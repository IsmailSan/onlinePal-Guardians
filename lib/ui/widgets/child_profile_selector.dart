import 'package:flutter/material.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_state.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/ui/screens/profile/child_profile_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_dropdown.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class ChildProfileSelector extends StatefulWidget {
  final void Function(ChildProfile profile)? onProfileChanged;

  const ChildProfileSelector({super.key, this.onProfileChanged});

  @override
  State<ChildProfileSelector> createState() => _ChildProfileSelectorState();
}

class _ChildProfileSelectorState extends State<ChildProfileSelector> {
  List<ChildProfile> profiles = [];
  ChildProfile? selectedProfile;
  int? selectedProfileId;
  bool hasInitializedProfile = false;

  @override
  void initState() {
    super.initState();
    _loadProfileId();
    context.read<ChildProfileBloc>().add(GetChildrenProfile());
  }

  void _loadProfileId() async {
    final profile = await SessionHelper().getChildProfile();
    final childProfileId = profile?.id ?? 0;

    setState(() {
      selectedProfileId = childProfileId;
    });
  }

  void _setAndSaveSelectedProfileId(ChildProfile childProfile) {
    SessionHelper().saveChildProfile(childProfile);

    final profile = profiles.firstWhere((p) => p.id == childProfile.id,
        orElse: () => profiles.first);

    setState(() {
      selectedProfileId = childProfile.id;
      selectedProfile = profile;
    });

    widget.onProfileChanged?.call(profile);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildProfileBloc, ChildProfileState>(
      buildWhen: (previous, current) => current is GetChildrenProfileSuccess,
      builder: (context, state) {
        if (state is GetChildrenProfileSuccess) {
          profiles = state.response.data ?? [];

          if (!hasInitializedProfile && profiles.isNotEmpty) {
            selectedProfile = profiles.first;
            hasInitializedProfile = true;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _setAndSaveSelectedProfileId(selectedProfile!);
            });
          }
        }

        return ChildProfileDropdown(
          profiles: profiles,
          selectedProfileId: selectedProfileId,
          onProfileSelected: (profile) {
            _setAndSaveSelectedProfileId(profile);
          },
          onAddNew: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChildProfileScreen()),
            ).then((_) {
              context.read<ChildProfileBloc>().add(GetChildrenProfile());
              _loadProfileId();
            });
          },
        );
      },
    );
  }
}
