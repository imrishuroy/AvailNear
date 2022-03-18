import 'package:finding_home/blocs/bloc/auth_bloc.dart';
import 'package:finding_home/constants/constants.dart';
import 'package:finding_home/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/one_post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          _authBloc.state.user?.photoUrl ?? errorImage,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Hi'),
                      Text(
                        'Rishu Kumar',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const CustomContainer(
                    child: Center(
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Find',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '\nbest place ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'nearby ✌️',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Bhopal, Patel Nagar',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 22.0,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  // contentPadding: contentPadding,
                  fillColor: const Color(0xff262626),
                  //fillColor: const Color(0xffCAF0F8),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: const Icon(
                    Icons.sort,
                    color: Colors.white,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    letterSpacing: 1.0,
                  ),
                  hintText: 'Search your nearby',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: _canvas.height * 0.5,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const OnePostCard();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
