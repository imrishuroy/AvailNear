import 'package:availnear/config/shared_prefs.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '/blocs/bloc/auth_bloc.dart';
import '/notification/cubit/notif_cubit.dart';
import '/repositories/notification/notification_repository.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      child: ListView.builder(
                        itemCount: state.notifs.length,
                        itemBuilder: (context, index) {
                          final notif = state.notifs[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                  'https://cdn-icons.flaticon.com/png/128/2549/premium/2549900.png?token=exp=1651008957~hmac=cf4210dcc4e766f831e5ecabcdd0d6cc',
                                  height: 25.0,
                                  width: 25.0,
                                ),
                                title: Text(
                                  notif?.content ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // subtitle: Text(notif?.content ?? ''),

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
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
