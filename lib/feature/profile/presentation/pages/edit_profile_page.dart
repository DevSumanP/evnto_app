import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/profile/domain/entities/user_profile.dart';
import 'package:tap_app/feature/profile/domain/usecases/update_profile_use_case.dart';
import 'package:tap_app/feature/profile/presentation/blocs/profile_bloc.dart';
import 'package:tap_app/shared/widgets/buttons/primary_button.dart';

enum EditField { name, password, phone, city, country }

class FieldConfig {
  const FieldConfig({
    required this.title,
    required this.description,
    required this.label,
    this.keyboard = TextInputType.text,
    this.obscure = false,
  });

  final String title, description, label;
  final TextInputType keyboard;
  final bool obscure;
}

const Map<EditField, FieldConfig> kFieldConfig = <EditField, FieldConfig>{
  EditField.name: FieldConfig(
    title: 'Change Name',
    description:
        "Don't worry, sometimes people want a fresh start. Enter your new name below.",
    label: 'Name',
  ),
  EditField.password: FieldConfig(
    title: 'Change Password',
    description:
        "Don't worry, keeping your account safe is smart. Enter your new password below.",
    label: 'New password',
    obscure: true,
  ),
  EditField.phone: FieldConfig(
    title: 'Change Phone',
    description:
        "Don't worry, you can update this anytime. Enter your new number below.",
    label: 'Phone',
    keyboard: TextInputType.phone,
  ),
  EditField.city: FieldConfig(
    title: 'Change City',
    description: "Don't worry, moving happens. Enter your city below.",
    label: 'City',
  ),
  EditField.country: FieldConfig(
    title: 'Change Country',
    description:
        "Don't worry, you can update this anytime. Enter your country below.",
    label: 'Country',
  ),
};

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    super.key,
    required this.profile,
    required this.field,
  });

  final UserProfile profile;
  final EditField field;

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => inject<ProfileBloc>(),
      child: _EditView(profile: profile, field: field),
    );
  }
}

class _EditView extends StatefulWidget {
  const _EditView({required this.profile, required this.field});

  final UserProfile profile;
  final EditField field;

  @override
  State<_EditView> createState() => _EditViewState();
}

class _EditViewState extends State<_EditView> {
  late final TextEditingController _controller = TextEditingController(
    text: switch (widget.field) {
      EditField.name => widget.profile.displayName,
      EditField.phone => widget.profile.phone ?? '',
      EditField.city => widget.profile.city ?? '',
      EditField.country => widget.profile.country ?? '',
      EditField.password => '',
    },
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _textOrNull(final String s) {
    final t = s.trim();
    return t.isEmpty ? null : t;
  }

  void _onSave(final BuildContext context) {
    FocusScope.of(context).unfocus();
    final value = _textOrNull(_controller.text);
    switch (widget.field) {
      case EditField.name:
        context.read<ProfileBloc>().add(
          ProfileEvent.saveRequested(UpdateProfileParams(displayName: value)),
        );
      case EditField.phone:
        context.read<ProfileBloc>().add(
          ProfileEvent.saveRequested(UpdateProfileParams(phone: value)),
        );
      case EditField.city:
        context.read<ProfileBloc>().add(
          ProfileEvent.saveRequested(UpdateProfileParams(city: value)),
        );
      case EditField.country:
        context.read<ProfileBloc>().add(
          ProfileEvent.saveRequested(UpdateProfileParams(country: value)),
        );
      case EditField.password:
        final password = _controller.text.trim();
        if (password.length < 8) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password must be at least 8 characters'),
            ),
          );
          return;
        }
        context.read<ProfileBloc>().add(
          ProfileEvent.passwordChangeRequested(password),
        );
    }
  }

  @override
  Widget build(final BuildContext context) {
    final config = kFieldConfig[widget.field]!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          config.title,
          style: AppTextStyles.h4Bold.copyWith(color: AppColors.text500),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
          listener: (final BuildContext context, final ProfileState state) {
            if (state.saveSucceeded) {
              // Signal the profile page to refresh, then close.
              context.router.maybePop(true);
            } else if (state.saveStatus == ProfileSaveStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.saveError ?? 'Could not save')),
              );
            }
          },
          builder: (final BuildContext context, final ProfileState state) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: <Widget>[
                Text(
                  config.description,
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.text300,
                  ),
                ),
                const SizedBox(height: 20),
                _Field(
                  label: config.label,
                  controller: _controller,
                  obscure: config.obscure,
                  keyboard: config.keyboard,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  height: 52,
                  label: 'Save changes',
                  isLoading: state.isLoading,
                  onPressed: state.isSaving ? null : () => _onSave(context),
                  backgroundColor: AppColors.primary,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.keyboard = TextInputType.text,
    this.obscure = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool obscure;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.captionBold.copyWith(color: AppColors.text300),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboard,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.text10,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
