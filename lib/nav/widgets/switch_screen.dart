import 'package:flutter/material.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/girl-table/girl_table.dart';
import '/screens/mentor-connect/mentor_connect.dart';
import '/screens/profile/profile_screen.dart';

import '/enums/nav_item.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        return const DashBoard();

      case NavItem.nearby:
        return const GirlTable();

      case NavItem.search:
        return const MentorConnect();

      case NavItem.profile:
        return const ProfileScreen();

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}
