import '/config/shared_prefs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '/repositories/auth/auth_repository.dart';

import '/widgets/error_dialog.dart';
import '/widgets/google_button.dart';

import '/widgets/loading_indicator.dart';
import 'package:universal_platform/universal_platform.dart';

import 'choose_user_type.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;

    print('User Type - -- ${SharedPrefs().getUserType}');
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              // backgroundColor: Colors.black,
              body: state.status == LoginStatus.submitting
                  ? const LoadingIndicator()
                  : SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(height: 60.0),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                'Availnear',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            '" get what\'s available nearby "',
                            style: GoogleFonts.notoSans(
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
                          Image.asset(
                            'assets/images/login.png',
                            height: 350.0,
                            width: 450.0,
                            fit: BoxFit.cover,
                          ),
                          //const SizedBox(height: 20.0),
                          const ChooseUserType(),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: 300.0,
                            child: SignInWithAppleButton(
                              onPressed: () {
                                if (!UniversalPlatform.isIOS) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const ErrorDialog(
                                        content:
                                            'Apple login is currently available only on iOS devices!'),
                                  );
                                } else {
                                  context.read<LoginCubit>().appleLogin();
                                }
                              },
                              style: SignInWithAppleButtonStyle.black,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text('or'),
                          const SizedBox(height: 10.0),
                          GoogleSignInButton(
                            onPressed: () =>
                                context.read<LoginCubit>().googleSignIn(),
                            title: 'Sign in with Google',
                          ),
                          const SizedBox(height: 5.0),
                          Text.rich(
                            TextSpan(
                              // text: 'By clicking the ',
                              children: <InlineSpan>[
                                const TextSpan(text: ' By clicking the '),
                                const TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                const TextSpan(
                                    text: ' button you agree to the '),
                                TextSpan(
                                  text: 'T&C ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => print('tapped'),
                                  // _launchInBrowser(termsOfService),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13.0,
                            ),
                          ),
                          const SizedBox(height: 40.0)
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
