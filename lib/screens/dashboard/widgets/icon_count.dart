import 'package:flutter/material.dart';

class IconCount extends StatelessWidget {
  final IconData icon;
  final int? count;

  const IconCount({Key? key, required this.icon, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 22.0,
        ),
        const SizedBox(width: 3.0),
        Text('${count ?? 'N/A'}'),
      ],
    );
  }
}
