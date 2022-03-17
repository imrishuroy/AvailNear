import 'package:finding_home/config/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '/repositories/auth/auth_repository.dart';

import '/widgets/error_dialog.dart';
import '/widgets/google_button.dart';
import '/widgets/greetings_widget.dart';
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
    final height = MediaQuery.of(context).size.height;

    print('User Type - -- ${SharedPrefs().getUserType}');
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black54,
        statusBarIconBrightness: Brightness.light,
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
              backgroundColor: Colors.black,
              body: state.status == LoginStatus.submitting
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: LoadingIndicator(),
                    )
                  : ListView(
                      children: <Widget>[
                        GreetingsWidget(height: height),
                        SizedBox(height: height < 750 ? 15.0 : 12.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 22.0, left: 20.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(height: 60.0),
                              const ChooseUserType(),
                              const SizedBox(height: 60.0),
                              if (UniversalPlatform.isIOS)
                                SizedBox(
                                  width: 250.0,
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
                                    style: SignInWithAppleButtonStyle.white,
                                  ),
                                ),
                              const SizedBox(height: 20.0),
                              GoogleSignInButton(
                                onPressed: () =>
                                    context.read<LoginCubit>().googleSignIn(),
                                title: 'Sign in with Google',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25.0),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
