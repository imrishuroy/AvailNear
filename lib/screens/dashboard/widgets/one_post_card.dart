import 'package:finding_home/screens/dashboard/widgets/icon_count.dart';
import 'package:flutter/material.dart';

class OnePostCard extends StatelessWidget {
  const OnePostCard({Key? key}) : super(key: key);

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
                height: 150.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://media.istockphoto.com/photos/europe-modern-complex-of-residential-buildings-picture-id1165384568?k=20&m=1165384568&s=612x612&w=0&h=CAnAr3uJtmkr0IQ2EPgm0IBoo8oCm-FEYEtyor8X_9I='),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Duplex Apartment',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text('Bhopal, Patel Nagar'),
                  const SizedBox(height: 8.0),
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

                  //   const SizedBox(height: .0),
                  SizedBox(
                    height: 30.0,
                    width: _canvas.width * 0.5,
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled',
                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  SizedBox(
                    width: _canvas.width * 0.53,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '₹3000',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
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
