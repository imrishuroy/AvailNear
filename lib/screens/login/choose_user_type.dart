import 'package:finding_home/config/shared_prefs.dart';
import 'package:finding_home/enums/user_type.dart';
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
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/owner.png',
                height: 100.0,
                width: 100.0,
              ),
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
              )
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/renter.png',
                height: 100.0,
                width: 100.0,
              ),
              Radio<UserType>(
                value: UserType.renter,
                groupValue: _type,
                onChanged: (UserType? value) async {
                  if (value != null) {
                    await SharedPrefs().setUserType(renter);
                    setState(() {
                      _type = value;
                    });
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
