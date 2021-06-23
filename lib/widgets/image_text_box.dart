import 'package:flutter/material.dart';

class ImageTextBox extends StatelessWidget {
  const ImageTextBox({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: IntrinsicWidth(
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black45,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Image.asset(
                                  imageUrl,
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 10,
                                  child: Container(
                                    width: width / 10,
                                    height: height / 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: width / 300,
                                        ),
                                        Text(
                                          '308',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: width / 150),
                                        ),
                                        SizedBox(
                                          width: width / 600,
                                        ),
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                          size: width / 140,
                                        ),
                                        SizedBox(
                                          width: width / 200,
                                        ),
                                        Text(
                                          'Ahmed Alharabi, 10:39',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: width / 150),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Text('data', style: TextStyle(color: Colors.white)),
                        ],
                      )),
                ),
                Positioned(
                    right: 15,
                    bottom: 4.5,
                    child: Text(
                      '10:30',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
