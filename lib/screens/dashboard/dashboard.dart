import '/models/place_details.dart';
import '/screens/search-place/search_screen.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/widgets/display_image.dart';
import '/screens/dashboard/cubit/post_cubit.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/widgets/custom_container.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'widgets/one_posts_card.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();

    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final possition = await LocationUtil.getCurrentAddress();
      // }
      //  print('Location ${await LocationUtil.getCurrentLocation()}'),
      //),
      body: BlocConsumer<DashBoardBloc, DashBoardState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == DashBoardStatus.loading) {
            return const LoadingIndicator();
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 10.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14.0),
                                child: DisplayImage(
                                  imageUrl: _authBloc.state.user?.photoUrl,
                                  height: 45.0,
                                  width: 45.0,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Hi'),
                                  SizedBox(
                                    width: _canvas.width * 0.5,
                                    child: Text(
                                      _authBloc.state.user?.name ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              CustomContainer(
                                child: Center(
                                  child: Stack(
                                    children: const [
                                      Icon(
                                        Icons.notifications_outlined,
                                        color: Colors.blue,
                                      ),
                                      Positioned(
                                        top: 1.8,
                                        right: 1.9,
                                        child: CircleAvatar(
                                          radius: 4.0,
                                          backgroundColor: Colors.red,
                                        ),
                                      )
                                    ],
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
                                    //color: Color(0xff00c6e9),
                                    //color: Color(0xff00bee9),
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
                              const SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () async {
                                  final placeDetails =
                                      await Navigator.of(context)
                                              .pushNamed(SearchScreen.routeName)
                                          as PlaceDetails?;
                                  print('Place details $placeDetails');
                                  if (placeDetails?.formatedAddress != null) {
                                    context.read<DashBoardBloc>().add(
                                          LoadCurrentAddress(
                                              address: placeDetails!
                                                  .formatedAddress),
                                        );
                                  }
                                },
                                child: const Icon(
                                  Icons.my_location,
                                  size: 22.0,
                                  color: Colors.redAccent,
                                ),
                              ),

                              //Icon(Icons.arrow_drop_down)
                            ],
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            state.currentAddress ?? 'N/A',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       width: _canvas.width * 0.75,
                          //       child: Text(
                          //         state.currentAddress ?? 'N/A',
                          //         // 'Bhopal, Patel Nagar',
                          //         style: const TextStyle(fontSize: 16.0),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 4.0),
                          //     const Icon(
                          //       Icons.location_on,
                          //       color: Colors.redAccent,
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 17.0),
                        ],
                      ),
                    ),
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
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: _canvas.height * 0.55,
                      child: BlocConsumer<PostCubit, PostState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state.status == PostStatus.loading) {
                            return const LoadingIndicator();
                          }
                          return ListView.builder(
                            itemCount: state.posts?.length,
                            itemBuilder: (context, index) {
                              final post = state.posts?[index];
                              final likedPostsState =
                                  context.watch<LikedPostsCubit>().state;
                              final isLiked = likedPostsState.likedPostIds
                                  .contains(post?.postId);

                              // final recentlyLiked = likedPostsState
                              //     .recentlyLikedPostIds
                              //     .contains(post?.postId);
                              return OnePostCard(
                                post: state.posts?[index],
                                isWishlisted: isLiked,
                                onTap: () {
                                  if (isLiked) {
                                    context
                                        .read<LikedPostsCubit>()
                                        .unlikePost(post: post!);
                                  } else {
                                    context
                                        .read<LikedPostsCubit>()
                                        .likePost(post: post);
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
