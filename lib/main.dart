import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'metamask_provider.dart';
import 'chatModels.dart';
import 'conversationList.dart';

void main() {
  runApp(
    const MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers(
          name: "Jane Russel",
          messageText: "Awesome setup!! ",
          imageURL: "images/userImage1.jpeg",
          time: "Now"),
      ChatUsers(
          name: "Gladys Murphy",
          messageText: "That's great :)",
          imageURL: "images/userImage2.jpeg",
          time: "Yesterday"),
      ChatUsers(
          name: "Jorge Henry",
          messageText: "Hey, where are you?",
          imageURL: "images/userImage3.jpeg",
          time: "31 Mar"),
      ChatUsers(
          name: "Philip Fox",
          messageText: "Busy! Call me in 20. ",
          imageURL: "images/userImage4.jpeg",
          time: "28 Mar"),
      ChatUsers(
          name: "Debra Hawkins",
          messageText: "Thanks, it's awesome :)",
          imageURL: "images/userImage5.jpeg",
          time: "23 Mar"),
      ChatUsers(
          name: "Jacob Pena",
          messageText: "will update you in evening.",
          imageURL: "images/userImage6.jpeg",
          time: "17 Mar"),
      ChatUsers(
          name: "Andrey Jones",
          messageText: "Can you please share the file?",
          imageURL: "images/userImage7.jpeg",
          time: "24 Feb"),
      ChatUsers(
          name: "John Wick",
          messageText: "How are you?",
          imageURL: "images/userImage8.jpeg",
          time: "18 Feb"),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF415687),
      body: ChangeNotifierProvider(
          create: (context) => MetaMaskProvider()..start(),
          builder: (context, child) {
            return Center(
              child: Consumer<MetaMaskProvider>(
                  builder: (context, provider, child) {
                late final String message;
                if (provider.isConnected && provider.isInOperatingChain) {
                  return Scaffold(
                    backgroundColor: const Color(0xFF415687),
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    "Conversations",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF7F0F5)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 2, bottom: 2),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xFFE57A44),
                                    ),
                                    child: const Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.add,
                                          color: Color(0xFFF7F0F5),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Add New",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF7F0F5)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search...",
                                hintStyle:
                                    const TextStyle(color: Color(0xFF415687)),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFF415687),
                                  size: 20,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF7F0F5),
                                contentPadding: const EdgeInsets.all(8),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF7F0F5),
                                    )),
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: chatUsers.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ConversationList(
                                name: chatUsers[index].name,
                                messageText: chatUsers[index].messageText,
                                imageUrl: chatUsers[index].imageURL,
                                time: chatUsers[index].time,
                                isMessageRead:
                                    (index == 0 || index == 3) ? true : false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (provider.isConnected &&
                    !provider.isInOperatingChain) {
                  message =
                      'Wrong chain. Please connect to ${MetaMaskProvider.operatingChain}';
                } else if (provider.isEnabled) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Welcome to ChatApp",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFF7F0F5), fontSize: 30),
                          )),
                      MaterialButton(
                          onPressed: () =>
                              context.read<MetaMaskProvider>().connect(),
                          color: Color(0xFFF7F0F5),
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                width: 250,
                              )
                            ],
                          ))
                    ],
                  );
                } else {
                  message = 'Please use a Web3 supported browser.';
                }
                return Text(
                  message,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(color: Color(0xFFF7F0F5)),
                );
              }),
            );
          }),
    );
  }
}
