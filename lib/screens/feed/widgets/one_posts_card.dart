import '/constants/constants.dart';
import '/models/post.dart';
import '/screens/dashboard/widgets/icon_count.dart';
import 'package:flutter/material.dart';

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
    final _canvas = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Row(
            children: [
              Container(
                height: 160.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(post?.images[0] ?? errorImage),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _canvas.width * 0.4,
                    height: 20,
                    child: Text(
                      post?.title ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  //Text(post?.address ?? 'N/A'),
                  SizedBox(
                    width: _canvas.width * 0.4,
                    height: 20,
                    child: Text(post?.address ?? 'N/A'),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    // width: 150.0,
                    width: _canvas.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        IconCount(
                          icon: Icons.bed,
                          count: 5,
                        ),
                        Spacer(),
                        IconCount(
                          icon: Icons.bed,
                          count: 5,
                        ),
                        Spacer(),
                        IconCount(
                          icon: Icons.living_outlined,
                          count: 5,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  SizedBox(
                    height: 32.0,
                    width: _canvas.width * 0.5,
                    child: Text(
                      post?.description ?? 'N/A',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  SizedBox(
                    width: _canvas.width * 0.53,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹${post?.price ?? ''}',
                                style: const TextStyle(
                                  color: Colors.blue,
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
