// ==============================================================================
// lib/feature/auth/presentation/pages/login_page.dart
// Email + password sign-in screen. Driven by LoginBloc.
//
// Local state is intentionally minimal: only the two TextEditingControllers
// live in the widget so the cursor / selection behaves naturally. Everything
// else (errors, status, obscure toggle) is read from LoginState.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/image_constants.dart';
import '../../../../core/di/core_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../domain/validators/email_validator.dart';
import '../../domain/validators/password_validator.dart';
import '../blocs/login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => inject<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    context.read<LoginBloc>().add(const LoginEvent.submitted());
  }

  void _onSocialSignIn(String provider) {
    // OAuth flows live in a follow-up. Stub keeps the buttons wired.
    _goPostAuth();
  }

  void _goPostAuth() {
    final bool hasLocation = inject<StorageService>().isUserLocationSet;
    final PageRouteInfo next = hasLocation
        ? const MainShellRoute()
        : const ChooseLocationRoute();
    context.router.replaceAll([next]);
  }

  Future<void> _onBack() async {
    final popped = await context.router.maybePop();
    if (!popped && mounted) {
      context.router.replaceAll([const OnBoardRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,

        // Bottom navigation bar (Android)
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (prev, curr) =>
                prev.status != curr.status ||
                prev.failureMessage != curr.failureMessage,
            listener: (context, state) {
              if (state.isSuccess) {
                _goPostAuth();
                return;
              }
              final message = state.failureMessage;
              if (state.status == LoginStatus.failure && message != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.errorLight,
                      content: Text(
                        message,
                        style: AppTextStyles.bodySmallMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.text500,
                                ),
                                onPressed: _onBack,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'Hey there, welcome back!',
                              textAlign: TextAlign.left,
                              style: AppTextStyles.h4Bold.copyWith(
                                color: AppColors.text500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "We're glad to see you again. Sign in to "
                              'continue managing your tickets and events.',
                              textAlign: TextAlign.left,
                              style: AppTextStyles.bodySmallRegular.copyWith(
                                color: AppColors.text300,
                              ),
                            ),
                            const SizedBox(height: 32),
                            _AuthTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.mail_outline,
                              errorText: state.emailError == null
                                  ? null
                                  : EmailValidator.message(state.emailError!),
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginEvent.emailChanged(value)),
                              onSubmitted: (_) => _onSubmit(),
                            ),
                            const SizedBox(height: 12),
                            _AuthTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              obscureText: state.obscurePassword,
                              prefixIcon: Icons.lock_outline,
                              errorText: state.passwordError == null
                                  ? null
                                  : PasswordValidator.message(
                                      state.passwordError!,
                                    ),
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginEvent.passwordChanged(value)),
                              onSubmitted: (_) => _onSubmit(),
                              suffix: IconButton(
                                icon: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.text200,
                                  size: 20,
                                ),
                                onPressed: () => context.read<LoginBloc>().add(
                                  const LoginEvent.passwordVisibilityToggled(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: state.isSubmitting ? null : () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.bodySmallBold.copyWith(
                                    color: AppColors.text500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              label: 'Sign In',
                              isLoading: state.isSubmitting,
                              isDisabled: state.isSubmitting,
                              onPressed: _onSubmit,
                              backgroundColor: AppColors.primary,
                            ),
                            const SizedBox(height: 28),
                            const _OrDivider(),
                            const SizedBox(height: 28),
                            SecondaryButton(
                              label: 'Sign In with Google',
                              icon: SvgPicture.asset(
                                ImageConstants.google,
                                height: 18,
                                width: 18,
                              ),
                              onPressed: state.isSubmitting
                                  ? null
                                  : () => _onSocialSignIn('google'),
                            ),
                            const SizedBox(height: 12),
                            SecondaryButton(
                              label: 'Sign In with Apple',
                              icon: SvgPicture.asset(
                                ImageConstants.apple,
                                height: 18,
                                width: 18,
                              ),
                              onPressed: state.isSubmitting
                                  ? null
                                  : () => _onSocialSignIn('apple'),
                            ),
                            const Spacer(),
                            const _TermsFooter(actionWord: 'sign in'),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: obscureText
          ? TextInputAction.done
          : TextInputAction.next,
      style: AppTextStyles.bodySmallRegular.copyWith(color: AppColors.text500),
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        errorStyle: AppTextStyles.captionRegular.copyWith(
          color: AppColors.errorLight,
        ),
        hintStyle: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.text200,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.text200, size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.grey100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: hasError
              ? const BorderSide(color: AppColors.errorLight)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? AppColors.errorLight : AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorLight),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 1.5),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.grey300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or',
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: AppColors.text300,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.grey300, thickness: 1)),
      ],
    );
  }
}

class _TermsFooter extends StatelessWidget {
  const _TermsFooter({required this.actionWord});

  final String actionWord;

  @override
  Widget build(BuildContext context) {
    final base = AppTextStyles.captionRegular.copyWith(
      color: AppColors.text300,
    );
    final link = AppTextStyles.captionBold.copyWith(color: AppColors.text500);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: base,
        children: [
          TextSpan(text: 'By $actionWord, I accept the '),
          TextSpan(text: 'Terms of Service', style: link),
          const TextSpan(text: ' and '),
          TextSpan(text: 'Community Guidelines', style: link),
          const TextSpan(text: ' and have read '),
          TextSpan(text: 'Privacy Policy', style: link),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
