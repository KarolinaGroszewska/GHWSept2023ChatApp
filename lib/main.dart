import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'metamask_provider.dart';

void main() {
  runApp(
    const MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> contacts = [
      "Jonah Periwinkle",
      "Stacey Blueberry",
      "Grayson Indigo",
      "Flautist Spiceberry"
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
                  // message = 'Connected';
                  return ListView(
                      children: contacts.map((stringOne) {
                    return SizedBox(
                      width: 300,
                      height: 45,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Screen2(name: stringOne)));
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF7F0F5),
                              padding:
                                  const EdgeInsets.fromLTRB(175, 0, 175, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          child: Text(
                            stringOne,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList());
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
                          color: Colors.white,
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
                  style: const TextStyle(color: Colors.white),
                );
              }),
            );
          }),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F0F5),
      appBar: AppBar(
        title: Text("Chat with $name"),
        backgroundColor: const Color(0xFF415687),
      ),
    );
  }
}
