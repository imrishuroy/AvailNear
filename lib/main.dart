import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import '/repositories/post/post_repository.dart';
import '/config/auth_wrapper.dart';
import '/repositories/profile/profile_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/simple_bloc_observer.dart';

import '/config/custom_router.dart';
import 'blocs/bloc/auth_bloc.dart';
import 'config/shared_prefs.dart';
import 'constants/constants.dart';
import 'cubits/cubit/liked_posts_cubit.dart';
import 'repositories/auth/auth_repository.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

      /// systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark // status bar color
      ));
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyACn2d1FewBh4KugEvQ48DFivmTJkQzg1k',
    //     appId: '1:1812572046:web:ca0aa061fe63eba3fda6df',
    //     messagingSenderId: '1812572046',
    //     projectId: 'solution-challenge-2022-64113',
    //     storageBucket: 'solution-challenge-2022-64113.appspot.com',
    //   ),
    // );
  } else {
    await Firebase.initializeApp();
  }
  await SharedPrefs().init();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (_) => ProfileRepository(),
        ),
        RepositoryProvider<PostRepository>(
          create: (_) => PostRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LikedPostsCubit>(
            create: (context) => LikedPostsCubit(
              postRepository: context.read<PostRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            // scaffoldBackgroundColor: Colors.black54,
            primaryColor: primaryColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: primaryColor),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0.0,
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
              color: Colors.black54,
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
          // initialRoute: SharedPrefs().getUserType == null
          //     ? ChooseUser.routeName
          //     : AuthWrapper.routeName,
        ),
      ),
    );
  }
}
