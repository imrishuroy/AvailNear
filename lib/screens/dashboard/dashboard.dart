import 'dart:convert';
import '/notification/notification_screen.dart';
import '/widgets/show_snackbar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '/config/paths.dart';
import '/config/shared_prefs.dart';
import '/constants/constants.dart';
import '/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:timezone/data/latest.dart' as tz;
import '/models/place_details.dart';
import '/screens/search-place/search_screen.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/widgets/display_image.dart';
import '/screens/dashboard/cubit/post_cubit.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/widgets/custom_container.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'widgets/one_posts_card.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();

    if (SharedPrefs().getUserType == 'owner') {
      _notificationSetup();

      if (!UniversalPlatform.isWeb) {
        print('this init runs');
        tz.initializeTimeZones();
        RepositoryProvider.of<NotificationService>(context)
            .initialiseSettings(onSelectNotification);
      }
    }
  }

  bool _isLoading = false;
  Future<void> _notificationSetup() async {
    try {
      setState(() {
        _isLoading = true;
      });
      // asking for permissions
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      String? token = await messaging.getToken();
      //await messaging.deleteToken();
      print('FCM Token $token');

      print('Device token $token');
      print(
          'First time status ${SharedPrefs().isFirstTime}'); // if (token != null && !SharedPrefs().isFirstTime) {
      if (token != null) {
        print('server notification runs');

        // Save the initial token to the database
        await saveTokenToDatabase(token);

        // Any time the token refreshes, store this in the database too.
        FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

        //  await _serverNotification(token);
        SharedPrefs().setFirstTime();
        SharedPrefs().setNotificationStatus(true);
      }

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('Notification Settings $settings');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');

        //gives you the message on which user taps and it opened the app from terminated state

        //    await messaging.getAPNSToken();
        FirebaseMessaging.instance.getInitialMessage().then((message) {
          if (message != null) {
            // context
            //     .read<NavBloc>()
            //     .add(const UpdateNavItem(item: NavItem.store));
            print('Message1 $message');

            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     AuthWrapper.routeName, (route) => false);

            // if (message.data['route'] == 'public') {
            //   // BlocProvider.of<TabBloc>(context).add(UpdateTab(AppTab.public));
            // }
          }
        });

        ///Forground ( When the app is running in the forground )
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('Message 2 ${message.notification?.body}');
          // print('Message 2 ${message.notification.android.imageUrl}');
          print('Message 2 ${message.notification}');
          print('Mesage 3 ${message.data.runtimeType}');
          //print('Mesage 3 ${message.data['icons']}');
          print('Mesage 3 ${message.data}');

          final icon = message.data['icon'];

          if (message.notification != null) {
            final notification = context.read<NotificationService>();
            notification.showNotificationMediaStyle(
              title: message.notification?.title ?? '',
              body: message.notification?.body ?? '',
              payload: jsonEncode({
                'storyId': 'a',
                'storyAuthorId': '',
              }),
              mediaUrl: icon ?? profilePlaceholderImg,
            );

            // final String? storyId = message.data['storyId'];
            // final String? storyAuthorId = message.data['storyAuthorId'];
            // final String? icon = message.data['icon'];
            // final String? followerId = message.data['followerId'];

            // if (storyId != null && storyAuthorId != null) {
            //   // this is comment notificaiton from server
            //   notification.showNotificationMediaStyle(
            //     title: message.notification?.title ?? '',
            //     body: message.notification?.body ?? '',
            //     payload: jsonEncode({
            //       'storyId': storyId,
            //       'storyAuthorId': storyAuthorId,
            //     }),
            //     mediaUrl: icon ?? profilePlaceholderImg,
            //   );
            // }
            // // follower notification from server
            // if (followerId != null) {
            //   notification.showNotificationMediaStyle(
            //     title: message.notification?.title ?? '',
            //     body: message.notification?.body ?? '',
            //     payload: jsonEncode({
            //       'type': 'followerNotif',
            //       'followerId': followerId,
            //     }),
            //     mediaUrl: icon ?? profilePlaceholderImg,
            //   );
            // }

            // else {
            //   notification.showNotification(
            //     title: message.notification?.title ?? '',
            //     body: message.notification?.body ?? '',
            //     payload: 'no-action',
            //   );
            // }
          }
          // else {
          //   // work on this follower notifications
          //   if (message.data.isNotEmpty) {
          //     final followerData =
          //         jsonDecode(message.data['follower']) as Map<String, dynamic>?;

          //     final followerUserName =
          //         followerData?['_fieldsProto']['username']['stringValue'];
          //     print('this notif is not null');
          //     final notification = context.read<NotificationService>();
          //     notification.showNotification(
          //       title: 'New Follower',
          //       body: '${followerUserName ?? 'N/A'} followed you',
          //       payload: 'no-action',
          //     );
          //   }
          // }
        });

        ///When the app is in background but opened and user taps
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          print('Message2 ${message.data}');
          // context.read<NavBloc>().add(const UpdateNavItem(item: NavItem.store));
          // if (message.data['route'] == 'public') {
          //   // BlocProvider.of<TabBloc>(context).add(UpdateTab(AppTab.public));
          // }
        });
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error in Firebase message ${error.toString()}');
      setState(() {
        _isLoading = false;
      });
      print(error.toString());
    }
  }

  Future<void> onSelectNotification(String? payload) async {
    print('Nofication Clicked');
    print('Payload $payload');
    Navigator.of(context).pushNamed(NotificationScreens.routeName);

    // if (payload != null) {
    //   final notifData = jsonDecode(payload) as Map?;
    //   print('Comments data $notifData');

    //   if (notifData != null) {
    //     final String? storyId = notifData['storyId'];
    //     final String? storyAuthorId = notifData['storyAuthorId'];
    //     final notifType = notifData['type'];
    //     final followerId = notifData['followerId'];

    //     if (notifType == 'followerNotif' && followerId != null) {
    //       // Navigator.of(context).pushNamed(OthersProfileScreen.routeName,
    //       //     arguments: OthersProfileScreenArgs(othersProfileId: followerId));
    //     } else if (storyAuthorId != null && storyId != null) {
    //       // Navigator.of(context).pushNamed(
    //       // CommentsScreen.routeName,
    //       // arguments: CommentsScreenArgs(
    //       //   storyId: storyId,
    //       //   storyAuthorId: storyAuthorId,
    //       // ),
    //       // );
    //     }
    // }
    //}

//     final Map? payload = jsonDecode(payload);

    /// context.read<NavBloc>().add(const UpdateNavItem(item: NavItem.store));

    if (payload == 'public') {
      //  BlocProvider.of<TabBloc>(context).add(UpdateTab(AppTab.public));
    }
  }

  Future<void> saveTokenToDatabase(String token) async {
    try {
      // Assume user is logged in for this example
      print('server notification runs');

      final _authBloc = context.read<AuthBloc>();

      await FirebaseFirestore.instance
          .collection(Paths.users)
          .doc(_authBloc.state.user?.userId)
          .update({
        'tokens': FieldValue.arrayUnion([token]),
      });
    } catch (error) {
      print('Error adding token to the server ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
    print('Curent user ${_authBloc.state.user}');
    final _canvas = MediaQuery.of(context).size;
    print('User type --- ${SharedPrefs().getUserType}');
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final possition = await LocationUtil.getCurrentAddress();
      // }
      //  print('Location ${await LocationUtil.getCurrentLocation()}'),
      //),
      body: _isLoading
          ? const LoadingIndicator()
          : BlocConsumer<DashBoardBloc, DashBoardState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == DashBoardStatus.loading) {
                  return const LoadingIndicator();
                }

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                      left: 15.0,
                      top: 10.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(14.0),
                                      child: DisplayImage(
                                        imageUrl:
                                            _authBloc.state.user?.photoUrl,
                                        height: 45.0,
                                        width: 45.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Hi'),
                                        SizedBox(
                                          width: _canvas.width * 0.5,
                                          child: Text(
                                            _authBloc.state.user?.name ?? 'N/A',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(
                                              NotificationScreens.routeName),
                                      child: CustomContainer(
                                        child: Center(
                                          child: Stack(
                                            children: const [
                                              Icon(
                                                Icons.notifications_outlined,
                                                color: Colors.blue,
                                              ),
                                              Positioned(
                                                top: 1.8,
                                                right: 1.9,
                                                child: CircleAvatar(
                                                  radius: 4.0,
                                                  backgroundColor: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 25.0),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Find',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\nbest place ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'nearby ✌️',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          //color: Color(0xff00c6e9),
                                          //color: Color(0xff00bee9),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                    const SizedBox(width: 10.0),
                                    GestureDetector(
                                      onTap: () async {
                                        final placeDetails =
                                            await Navigator.of(context)
                                                    .pushNamed(
                                                        SearchScreen.routeName)
                                                as PlaceDetails?;
                                        print('Place details $placeDetails');
                                        if (placeDetails?.formatedAddress !=
                                            null) {
                                          context.read<DashBoardBloc>().add(
                                                LoadCurrentAddress(
                                                    address: placeDetails!
                                                        .formatedAddress),
                                              );
                                        }
                                      },
                                      child: const Icon(
                                        Icons.my_location,
                                        size: 22.0,
                                        color: Colors.redAccent,
                                      ),
                                    ),

                                    //Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  state.currentAddress ?? 'N/A',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     SizedBox(
                                //       width: _canvas.width * 0.75,
                                //       child: Text(
                                //         state.currentAddress ?? 'N/A',
                                //         // 'Bhopal, Patel Nagar',
                                //         style: const TextStyle(fontSize: 16.0),
                                //       ),
                                //     ),
                                //     const SizedBox(width: 4.0),
                                //     const Icon(
                                //       Icons.location_on,
                                //       color: Colors.redAccent,
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          // TextField(
                          //   decoration: InputDecoration(
                          //     fillColor: Colors.white,
                          //     // contentPadding: contentPadding,
                          //     // fillColor: const Color(0xff262626),
                          //     //fillColor: const Color(0xffCAF0F8),
                          //     filled: true,
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //       borderSide: BorderSide(color: Colors.grey.shade700),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //       borderSide: BorderSide(color: Colors.grey.shade700),
                          //     ),
                          //     prefixIcon: const Icon(
                          //       Icons.search,
                          //       color: Colors.black,
                          //     ),
                          //     suffixIcon: const Icon(
                          //       Icons.sort,
                          //       color: Colors.black,
                          //     ),
                          //     labelStyle: const TextStyle(
                          //       color: Colors.white,
                          //       fontFamily: 'Montserrat',
                          //       fontSize: 14.0,
                          //       letterSpacing: 1.0,
                          //     ),
                          //     hintText: 'Search your nearby',
                          //     hintStyle: const TextStyle(color: Colors.black),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: _canvas.height * 0.6,
                            child: BlocConsumer<PostCubit, PostState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state.status == PostStatus.loading) {
                                  return const LoadingIndicator();
                                }
                                return AnimationLimiter(
                                  child: ListView.builder(
                                    itemCount: state.posts?.length,
                                    itemBuilder: (context, index) {
                                      final post = state.posts?[index];
                                      final likedPostsState = context
                                          .watch<LikedPostsCubit>()
                                          .state;
                                      final isLiked = likedPostsState
                                          .likedPostIds
                                          .contains(post?.postId);

                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: OnePostCard(
                                              post: state.posts?[index],
                                              isWishlisted: isLiked,
                                              onTap: () {
                                                if (isLiked) {
                                                  context
                                                      .read<LikedPostsCubit>()
                                                      .unlikePost(post: post!);
                                                } else {
                                                  ShowSnackBar.showSnackBar(
                                                      context,
                                                      title:
                                                          '${post?.title ?? 'Post'} added to your wishlist');
                                                  context
                                                      .read<LikedPostsCubit>()
                                                      .likePost(post: post);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 200.0)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
