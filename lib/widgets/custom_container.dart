import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      width: 43.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(14.0),
        // image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: NetworkImage(
        //     _authBloc.state.user?.photoUrl ?? errorImage,
        //   ),
        // ),
      ),
      child: child,
    );
  }
}
