import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '/config/shared_prefs.dart';
import '/constants/constants.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/notification/cubit/notif_cubit.dart';
import '/repositories/notification/notification_repository.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export '/extensions/extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreens extends StatelessWidget {
  static const String routeName = '/notifs';
  const NotificationScreens({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => NotifCubit(
          notificationRepository: context.read<NotificationRepository>(),
        )..fetchNotifs(ownerId: context.read<AuthBloc>().state.user?.userId),
        child: const NotificationScreens(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SharedPrefs().getUserType == rentee
          ? Center(
              child: Image.network(
                  'https://cdni.iconscout.com/illustration/premium/thumb/no-notification-4790933-3989286.png'),
            )
          : BlocConsumer<NotifCubit, NotifState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == NotifStatus.loading) {
                  return const LoadingIndicator();
                }
                return Column(
                  children: [
                    Expanded(
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: state.notifs.length,
                          itemBuilder: (context, index) {
                            final notif = state.notifs[index];
                            print('notif $notif');
                            final createdAt = notif?.createdAt != null
                                ? timeago.format(DateTime.tryParse(
                                    notif!.createdAt.toString())!)
                                : '';
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: NetworkImage(
                                            notif?.renteePhotoUrl ?? errorImage,
                                          ),
                                          // child: Image.network(
                                          //   notif?.renteePhotoUrl ?? errorImage,
                                          //   height: 25.0,
                                          //   width: 25.0,
                                          // ),
                                        ),
                                        title: Text(
                                          notif?.content ?? '',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(createdAt),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            launchUrlString(
                                                'tel://${notif?.renteePhNo}');
                                          },
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
