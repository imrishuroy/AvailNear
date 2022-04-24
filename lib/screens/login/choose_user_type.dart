import '/config/shared_prefs.dart';
import '/enums/user_type.dart';
import 'package:flutter/material.dart';

// enum UserType { owner, renter }

class ChooseUserType extends StatefulWidget {
  const ChooseUserType({Key? key}) : super(key: key);

  @override
  State<ChooseUserType> createState() => _ChooseUserTypeState();
}

class _ChooseUserTypeState extends State<ChooseUserType> {
  UserType _type = UserType.owner;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Radio<UserType>(
                value: UserType.owner,
                groupValue: _type,
                onChanged: (UserType? value) async {
                  if (value != null) {
                    await SharedPrefs().setUserType(owner);
                    setState(() {
                      _type = value;
                    });
                  }
                },
              ),
              const Text(
                'Rentee',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            children: [
              Radio<UserType>(
                value: UserType.renter,
                groupValue: _type,
                onChanged: (UserType? value) async {
                  if (value != null) {
                    await SharedPrefs().setUserType(rentee);
                    setState(() {
                      _type = value;
                    });
                  }
                },
              ),
              const Text(
                'Owner',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}






// import '/config/shared_prefs.dart';
// import '/enums/user_type.dart';
// import 'package:flutter/material.dart';

// // enum UserType { owner, renter }

// class ChooseUserType extends StatefulWidget {
//   const ChooseUserType({Key? key}) : super(key: key);

//   @override
//   State<ChooseUserType> createState() => _ChooseUserTypeState();
// }

// class _ChooseUserTypeState extends State<ChooseUserType> {
//   UserType _type = UserType.owner;
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(unselectedWidgetColor: Colors.black),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               Image.asset(
//                 'assets/owner.png',
//                 height: 100.0,
//                 width: 100.0,
//               ),
//               Radio<UserType>(
//                 value: UserType.owner,
//                 groupValue: _type,
//                 onChanged: (UserType? value) async {
//                   if (value != null) {
//                     await SharedPrefs().setUserType(owner);
//                     setState(() {
//                       _type = value;
//                     });
//                   }
//                 },
//               )
//             ],
//           ),
//           Column(
//             children: [
//               Image.asset(
//                 'assets/renter.png',
//                 height: 100.0,
//                 width: 100.0,
//               ),
//               Radio<UserType>(
//                 value: UserType.renter,
//                 groupValue: _type,
//                 onChanged: (UserType? value) async {
//                   if (value != null) {
//                     await SharedPrefs().setUserType(renter);
//                     setState(() {
//                       _type = value;
//                     });
//                   }
//                 },
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
