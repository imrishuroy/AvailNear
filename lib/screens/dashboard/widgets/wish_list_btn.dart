import 'package:flutter/material.dart';

class WishListBtn extends StatelessWidget {
  const WishListBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.favorite_border,
        color: Colors.grey,
      ),
    );
  }
}
