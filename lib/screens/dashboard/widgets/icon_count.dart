import 'package:flutter/material.dart';

class IconCount extends StatelessWidget {
  final IconData icon;
  final String? count;
  final String label;

  const IconCount({
    Key? key,
    required this.icon,
    this.count,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(count ?? 'N/A'),
            const SizedBox(width: 3.0),
            Icon(
              icon,
              color: Colors.black,
              size: 22.0,
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }
}
