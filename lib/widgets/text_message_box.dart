import 'package:flutter/material.dart';

class ChatContainerWidget extends StatelessWidget {
  const ChatContainerWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

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
                    child: Text(
                      'Missing android/data/org.telegram.messenger/cash folder\n\n'
                      '2 comments |'
                      ' ',
                      style: TextStyle(
                          height: 1.5, color: Colors.white, fontSize: 12),
                    ),
                  ),
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
