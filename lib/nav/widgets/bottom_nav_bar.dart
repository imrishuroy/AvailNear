import 'package:availnear/config/shared_prefs.dart';
import 'package:flutter/material.dart';
import '/enums/nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final NavItem? navItem;
  final Function(NavItem)? onitemSelected;

  const BottomNavBar({
    Key? key,
    @required this.navItem,
    @required this.onitemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
        right: 12.0,
        left: 12.0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20.0),
        //   topRight: Radius.circular(20.0),
        // ),
        child: BottomNavigationBar(
          elevation: 20.0,
          //landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          // type: BottomNavigationBarType.shifting,

          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          // backgroundColor: const Color(0xff96DEF4),
          iconSize: 20,
          selectedFontSize: 12,
          unselectedFontSize: 13,
          selectedItemColor: Colors.white,
          // selectedItemColor: const Color(0XFF00286E),
          //selectedItemColor: Colors.green,
          //unselectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: NavItem.values.indexOf(navItem!),
          onTap: (index) => onitemSelected!(NavItem.values[index]),
          items: NavItem.values.map((item) {
            return BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _itemIcon(item),
                ),
                label: _label(item));
          }).toList(),
        ),
      ),
    );
  }
}

Widget _itemIcon(NavItem item) {
  if (item == NavItem.dashboard) {
    return const Icon(Icons.dashboard);
  } else if (item == NavItem.addPost) {
    return SharedPrefs().getUserType == rentee
        ? const Icon(Icons.bookmark, size: 26.0)
        : const Icon(Icons.add, size: 26.0);
  } else if (item == NavItem.nearby) {
    return const Icon(Icons.near_me, size: 26.0);
  } else if (item == NavItem.profile) {
    return const Icon(Icons.person, size: 24.0);
  }

  return const Icon(Icons.person);
}

String _label(NavItem item) {
  if (item == NavItem.dashboard) {
    return 'Home';
  } else if (item == NavItem.addPost) {
    return SharedPrefs().getUserType == rentee ? 'Wishlist' : 'Add Post';
  } else if (item == NavItem.nearby) {
    return 'Nearby';
  } else if (item == NavItem.profile) {
    return 'Profile';
  }

  return '';
}
