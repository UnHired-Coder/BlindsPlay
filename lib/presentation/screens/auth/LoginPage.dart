import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart'; // Import your text styles
import '../../../util/firebase_auth.dart';
import '../../ui/widgets/base_cta_ui.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User? user;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        this.user = user;
        // If user is authenticated, pop the login page off the stack
        if (user != null) {
          Navigator.pop(context); // Navigate back to the previous screen
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Match background color
      appBar: AppBar(
        title: Text(
          'Login',
          style: AppTextStyles.heading3.copyWith(color: AppColors.accent),
        ),
        backgroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(AppSpacing.large), // Apply consistent padding
        child: Center(
          child: user == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BaseCtaUi(
                      text: 'Sign in with Google',
                      icon:
                          'assets/ic_google.png', // Replace with your Google icon path
                      context: context,
                      onTap: () async {
                        try {
                          await _authService.signInWithGoogle();
                        } catch (e) {
                          print("Failed to sign in with Google");
                        }
                      },
                    ),
                    SizedBox(
                        height: AppSpacing.large), // Spacing between buttons
                    InkWell(
                      child: Text(
                        'Continue as Guest',
                        style: AppTextStyles.bodyTextSmall.copyWith(
                            color: AppColors.onPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.onPrimary,
                            decorationThickness: 1),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () async {
                        try {
                          await _authService.signInAnonymously();
                        } catch (e) {
                          print("Failed to sign in as Guest");
                        }
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Signed in as ${user?.email ?? 'Guest'}',
                      style: AppTextStyles.bodyTextSmall
                          .copyWith(color: AppColors.onPrimary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20), // Spacing between text and button
                    ElevatedButton(
                      onPressed: () async {
                        await _authService.signOut();
                      },
                      child: Text('Sign Out'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
