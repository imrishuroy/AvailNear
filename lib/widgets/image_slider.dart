import 'package:carousel_slider/carousel_slider.dart';
import '/widgets/display_image.dart';
import '/widgets/no_image.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List? imgList;
  final double? borderRadius;
  final double bottomRadius;

  const ImageSlider({
    Key? key,
    required this.imgList,
    this.borderRadius,
    this.bottomRadius = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  String? name;

  @override
  Widget build(BuildContext context) {
    print('Image List ${widget.imgList}');
    print(name?.isNotEmpty);
    if (widget.imgList != null) {
      print('this runs ---');
      if (widget.imgList!.isEmpty) {
        print('this runs ---');
        return const SizedBox(child: NoImageAvailable());
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
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12.0),
                      topRight: const Radius.circular(12.0),
                      bottomLeft: Radius.circular(widget.bottomRadius),
                      bottomRight: Radius.circular(widget.bottomRadius),
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
