import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart'; // Import your text styles
import '../../../logic/blocs/login/login_bloc.dart';
import '../../../logic/blocs/login/login_event.dart';
import '../../../logic/blocs/login/login_state.dart';
import '../../ui/widgets/base_cta_ui.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          'Login',
          style: AppTextStyles.heading3.copyWith(color: AppColors.accent),
        ),
        backgroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.onPrimary,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pop(context); // Navigate back when authenticated
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildAuthOptions(context);
          }
        },
      ),
    );
  }

  Widget _buildAuthOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseCtaUi(
              text: 'Sign in with Google',
              icon: 'assets/ic_google.png',
              context: context,
              onTap: () {
                context.read<AuthBloc>().add(SignInWithGoogle());
              },
            ),
            SizedBox(height: AppSpacing.large),
            InkWell(
              child: Text(
                'Continue as Guest',
                style: AppTextStyles.bodyTextSmall.copyWith(
                  color: AppColors.onPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.onPrimary,
                  decorationThickness: 1,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                context.read<AuthBloc>().add(SignInAnonymously());
              },
            ),
          ],
        ),
      ),
    );
  }
}
