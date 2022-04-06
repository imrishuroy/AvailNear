import '/screens/feed/widgets/post_image_slider.dart';
import '/models/post.dart';
import 'package:flutter/material.dart';
import 'discription_text.dart';
import 'icon_count.dart';

class OnePostCard extends StatelessWidget {
  final Post? post;
  final bool isWishlisted;
  final VoidCallback onTap;
  const OnePostCard({
    Key? key,
    required this.post,
    this.isWishlisted = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _canvas = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostImageSlider(imgList: post?.images),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                post?.title ?? 'N/A',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    post?.address ?? 'N/A',
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7.0),
                  DescriptionTextWidget(
                    text: post?.description ?? 'N/A',
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      // bed, kitchen baathroom
                      IconCount(
                        icon: Icons.bed,
                        count: 2,
                        label: ' Bedroom',
                      ),
                      Spacer(),
                      IconCount(
                        icon: Icons.bathroom_outlined,
                        // icon: FontAwesomeIcons.bath,
                        count: 1,
                        label: ' Bathroom',
                      ),
                      Spacer(),
                      IconCount(
                        icon: Icons.kitchen_rounded,
                        count: 1,
                        label: '  Kitchen',
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '₹${post?.price ?? ''}',
                              style: const TextStyle(
                                color: Colors.blue,
                                //color: Color(0xff00c6e9),
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                            TextSpan(
                              text: ' /mo',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onTap,
                        icon: Icon(
                          isWishlisted ? Icons.bookmark : Icons.bookmark_add,
                          color: isWishlisted
                              ? Colors.black
                              : Colors.grey.shade600,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import '/constants/constants.dart';
// import '/models/post.dart';
// import '/screens/dashboard/widgets/icon_count.dart';
// import 'package:flutter/material.dart';

// class OnePostCard extends StatelessWidget {
//   final Post? post;
//   final bool isWishlisted;
//   final VoidCallback onTap;
//   const OnePostCard({
//     Key? key,
//     required this.post,
//     this.isWishlisted = false,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _canvas = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Card(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 10.0,
//             vertical: 10.0,
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 160.0,
//                 width: 100.0,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14.0),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(post?.images[0] ?? errorImage),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: _canvas.width * 0.4,
//                     height: 20,
//                     child: Text(
//                       post?.title ?? 'N/A',
//                       style: const TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 4.0),
//                   //Text(post?.address ?? 'N/A'),
//                   SizedBox(
//                     width: _canvas.width * 0.4,
//                     height: 20,
//                     child: Text(post?.address ?? 'N/A'),
//                   ),
//                   const SizedBox(height: 5.0),
//                   SizedBox(
//                     // width: 150.0,
//                     width: _canvas.width * 0.4,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: const [
//                         IconCount(
//                           icon: Icons.bed,
//                           count: 5,
//                         ),
//                         Spacer(),
//                         IconCount(
//                           icon: Icons.bed,
//                           count: 5,
//                         ),
//                         Spacer(),
//                         IconCount(
//                           icon: Icons.living_outlined,
//                           count: 5,
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 3.0),
//                   SizedBox(
//                     height: 32.0,
//                     width: _canvas.width * 0.5,
//                     child: Text(
//                       post?.description ?? 'N/A',
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   ),
//                   const SizedBox(height: 4.0),
//                   SizedBox(
//                     width: _canvas.width * 0.53,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: '₹${post?.price ?? ''}',
//                                 style: const TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18.0,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: ' /mo',
//                                 style: TextStyle(
//                                   color: Colors.grey.shade500,
//                                   fontSize: 14.0,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: onTap,
//                           icon: Icon(
//                             isWishlisted ? Icons.bookmark : Icons.bookmark_add,
//                             color: isWishlisted
//                                 ? Colors.black
//                                 : Colors.grey.shade600,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
