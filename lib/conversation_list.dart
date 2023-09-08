import 'package:flutter/material.dart';
import 'chat_detail.dart';

class ConversationList extends StatelessWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList(
      {super.key,
      required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ChatDetailPage();
        }));
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF7F0F5)),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            messageText,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE57A44)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Color(0xFFF7F0F5)),
            ),
          ],
        ),
      ),
    );
  }
}
