import 'package:availnear/widgets/error_dialog.dart';

import '/constants/constants.dart';
import '/screens/nearby/cubit/nearby_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/place_tile.dart';
import 'widgets/sort_button.dart';

class NearByScreen extends StatelessWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _nearbyCubit = context.read<NearbyCubit>().state;
    return BlocConsumer<NearbyCubit, NearbyState>(
      listener: (context, state) {
        if (state.status == NearbyStatus.error) {
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(content: state.failure.message),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              ' Explore Your NearBy 📍',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              // vertical: 10.0,
            ),
            child: BlocConsumer<NearbyCubit, NearbyState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == NearbyStatus.loading) {
                  return const LoadingIndicator();
                }
                return Column(
                  children: [
                    const SizedBox(height: 10.0),
                    SortButton(
                      dropDownOptions: nearbyCategatories,
                      onChanged: (value) => context
                          .read<NearbyCubit>()
                          .nearbyCategoryChanged(value),
                      selectedValue: state.nearbyCategory,
                    ),
                    // CustomDropDown(
                    //   labelText: 'CAUSES',
                    //   dropDownOptions: nearbyCategatories,
                    //   onChanged: (value) =>
                    //       context.read<NearbyCubit>().nearbyCategoryChanged(value),
                    //   selectedValue: state.nearbyCategory,
                    // ),
                    const SizedBox(height: 25.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.places.length,
                        itemBuilder: (context, index) {
                          final place = state.places[index];

                          return PlaceTile(place: place);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
