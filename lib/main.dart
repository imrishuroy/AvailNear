import '/repositories/notification/notification_repository.dart';
import '/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '/config/auth_wrapper.dart';
import '/repositories/nearby/nearby_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import '/repositories/post/post_repository.dart';
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

Future<void> backgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  // await FirebaseMessaging.instance.requestPermission();
  print(message.data.toString());
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

      /// systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark // status bar color
      ));
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDIfD-JZcOT1PkH34y_HmAiaj67YN2zxX4',
        appId: '1:428303357222:web:5201c28564877eea90dde7',
        messagingSenderId: '428303357222',
        projectId: 'finding-home-caca4',
        storageBucket: 'finding-home-caca4.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await SharedPrefs().init();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        ),
        RepositoryProvider<NearbyRepository>(
          create: (_) => NearbyRepository(),
        ),
        RepositoryProvider<NotificationService>(
          create: (_) => NotificationService(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (_) => NotificationRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              profileRepository: context.read<ProfileRepository>(),
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
            scaffoldBackgroundColor: Colors.white,
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

          //home: PlaceExp(),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: AuthWrapper.routeName,
          // initialRoute: AuthWrapper.routeName,
          // initialRoute: SharedPrefs().getUserType == null
          //     ? ChooseUser.routeName
          //     : AuthWrapper.routeName,
        ),
      ),
    );
  }
}
