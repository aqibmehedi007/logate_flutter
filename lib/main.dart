import 'package:flutter/material.dart';
import 'loqate_flutter.dart';
import 'src/address_search_screen.dart';  // Import AddressSearchScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address Search App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Replace `YOUR_API_KEY` with your actual Loqate API key
            final loqateService = LoqateService(apiKey: 'YB49-MH87-GC93-GY59');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressSearchScreen(loqateService: loqateService),
              ),
            );
          },
          child: Text('Go to Address Search'),
        ),
      ),
    );
  }
}
