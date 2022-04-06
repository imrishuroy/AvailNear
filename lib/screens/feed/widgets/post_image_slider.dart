import 'package:carousel_slider/carousel_slider.dart';
import '/widgets/display_image.dart';
import '/widgets/no_image.dart';
import 'package:flutter/material.dart';

class PostImageSlider extends StatefulWidget {
  final List? imgList;
  final double? borderRadius;

  const PostImageSlider({
    Key? key,
    required this.imgList,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<PostImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  String? name;

  @override
  Widget build(BuildContext context) {
    print('Image List ${widget.imgList}');
    print(name?.isNotEmpty);
    if (widget.imgList != null) {
      if (widget.imgList!.isEmpty) {
        return const SizedBox(height: 170.0, child: NoImageAvailable());
      }
    }

    return Column(
      children: [
        CarouselSlider(
          items: widget.imgList!
              .map(
                (item) => SizedBox(
                  //    height: 300.0,
                  // margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: DisplayImage(
                            imageUrl: item,
                            fit: BoxFit.cover,
                            // width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              // autoPlay: true,
              //enlargeCenterPage: true,
              aspectRatio: 1.8,
              //enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
