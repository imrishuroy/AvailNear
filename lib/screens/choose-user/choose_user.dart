// import '/config/auth_wrapper.dart';
// import '/config/shared_prefs.dart';
// import 'package:flutter/material.dart';

// class ChooseUser extends StatelessWidget {
//   static const routeName = '/choose-user';
//   const ChooseUser({Key? key}) : super(key: key);

//   static Route route() => MaterialPageRoute(
//         settings: const RouteSettings(name: routeName),
//         builder: (_) => const ChooseUser(),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 40.0,
//           vertical: 20.0,
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await SharedPrefs().setUserType(owner);
//                   Navigator.of(context).pushNamed(AuthWrapper.routeName);
//                 },
//                 child: const Text('Owner'),
//               ),
//               const SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   await SharedPrefs().setUserType(renter);
//                   Navigator.of(context).pushNamed(AuthWrapper.routeName);
//                 },
//                 child: const Text('Renter'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
