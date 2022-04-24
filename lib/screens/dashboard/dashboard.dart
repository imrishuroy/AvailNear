import '/screens/dashboard/cubit/post_cubit.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/widgets/custom_container.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'widgets/one_posts_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _authBloc = context.read<AuthBloc>();

    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<DashBoardBloc, DashBoardState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == FeedStatus.loading) {
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
                              Container(
                                height: 45.0,
                                width: 45.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/finding-home-caca4.appspot.com/o/profileImages%2Fz0PW9JMgAiNZtOxAOCAtwKi5WHn1?alt=media&token=8369fda4-b840-4bf3-a477-a81bd542a0a5'
                                        //'https://media.istockphoto.com/vectors/girl-petting-a-dog-vector-id1216956845?k=20&m=1216956845&s=612x612&w=0&h=Df8QyBEhwsZqZ7boeoH28Pvm6ulOTiqGQ8bEXNKLIIc='
                                        // 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                                        // _authBloc.state.user?.photoUrl ??
                                        //     errorImage,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Hi'),
                                  SizedBox(
                                    width: _canvas.width * 0.5,
                                    child: const Text(
                                      // 'Maidam',
                                      'Nishant',
                                      // _authBloc.state.user?.name ?? 'N/A',
                                      style: TextStyle(
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
