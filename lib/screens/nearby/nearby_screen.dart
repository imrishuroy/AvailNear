import '/screens/nearby/cubit/nearby_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/place_tile.dart';

class NearByScreen extends StatelessWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Explore Your NearBy',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                // contentPadding: contentPadding,
                // fillColor: const Color(0xff262626),
                //fillColor: const Color(0xffCAF0F8),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: const Icon(
                  Icons.sort,
                  color: Colors.black,
                ),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 14.0,
                  letterSpacing: 1.0,
                ),
                hintText: 'Search your nearby',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: BlocConsumer<NearbyCubit, NearbyState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == NearbyStatus.loading) {
                    return const LoadingIndicator();
                  }

                  return ListView.builder(
                    itemCount: state.places.length,
                    itemBuilder: (context, index) {
                      final place = state.places[index];

                      return PlaceTile(place: place);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
