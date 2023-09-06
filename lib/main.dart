import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'metamask_provider.dart';

void main() {
  runApp(
    const MaterialApp(home: MyApp()), // use MaterialApp
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.lightBlueAccent[600],
                        child: const Center(child: Text('Entry A')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.lightBlueAccent[500],
                        child: const Center(child: Text('Entry B')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.lightBlueAccent[100],
                        child: const Center(child: Text('Entry C')),
                      ),
                    ],
                  );
                } else if (provider.isConnected && !provider.isInOperatingChain){
                  message = 'Wrong chain. Please connect to ${MetaMaskProvider.operatingChain}';
                } else if (provider.isEnabled) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Welcome to ChatApps", 
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ),
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
                        )
                        )
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
              }
              ),
          );
        }
      ),
    );
  }
}