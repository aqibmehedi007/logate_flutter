
# loqate_flutter

`loqate_flutter` is a simple Flutter package that integrates with the Loqate API to provide address suggestion and detailed address retrieval services. It is designed to allow easy address lookup and retrieval for applications that need accurate address data in any country, including street names, suburb, city, state, and postal code.

## Features

- **Search Address**: Search for address suggestions based on a given query.
- **Get Address Details**: Retrieve detailed information for a selected address, including street name, suburb, city, state, and postal code.
- **Flexible Integration**: Easily integrate this package by providing an API key.
- **Support for Multiple Countries**: Allows you to specify a country code (e.g., AU for Australia, US for United States) for address searches.

## Installation

### 1. Add the dependency

Add `loqate_flutter` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  loqate_flutter:
    git:
      url: https://github.com/aqibmehedi007/logate_flutter.git
      ref: main # or the branch you want to use
```

### 2. Install dependencies

Run the following command in your terminal to install the package:

```bash
flutter pub get
```

## Usage

### Initialize the LoqateService

To use the service, initialize it with your Loqate API key.

```dart
import 'package:loqate_flutter/loqate_service.dart';

void main() {
  // Initialize with your Loqate API Key
  LoqateService loqateService = LoqateService(apiKey: 'YOUR_API_KEY');
}
```

### Search for Address Suggestions

Use the `searchAddress` method to get address suggestions based on a search query and country code.

```dart
Future<void> searchAddress(String query, String countryCode) async {
  List<Map<String, String>> suggestions = await loqateService.searchAddress(query, countryCode);

  suggestions.forEach((suggestion) {
    print('Address: ${suggestion['Text']}');
  });
}
```

### Get Detailed Address Information

Once a user selects an address, you can retrieve the detailed information using the `getAddressDetails` method.

```dart
Future<void> getAddressDetails(String id) async {
  Map<String, String> details = await loqateService.getAddressDetails(id);

  print('Unit/Flat No: ${details['unitOrFlatNo']}');
  print('Street: ${details['streetName']}');
  print('Suburb: ${details['suburb']}');
  print('City: ${details['city']}');
  print('State: ${details['state']}');
  print('Postal Code: ${details['postalCode']}');
}
```

### Example Code

```dart
import 'package:flutter/material.dart';
import 'package:loqate_flutter/loqate_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loqate API Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Loqate API Example'),
        ),
        body: AddressSearch(),
      ),
    );
  }
}

class AddressSearch extends StatefulWidget {
  @override
  _AddressSearchState createState() => _AddressSearchState();
}

class _AddressSearchState extends State<AddressSearch> {
  final LoqateService loqateService = LoqateService(apiKey: 'YOUR_API_KEY');
  List<String> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (query) {
            loqateService.searchAddress(query, 'AU').then((results) {
              setState(() {
                suggestions = results.map((e) => e['Text']).toList();
              });
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestions[index]),
                onTap: () {
                  // Handle tap on suggestion, for example to fetch detailed info
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
```

## API Key

To use the Loqate API, you will need an API key. You can get one from [Loqate](https://www.loqate.com/) by signing up for their API service.

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

### Contributing

If you would like to contribute to this project, feel free to fork the repository and create a pull request. We welcome any contributions, whether it's bug fixes, improvements, or new features!

---

### Contact

For any questions or issues, feel free to open an issue on [GitHub](https://github.com/yourgithub/loqate_flutter).

---

### Disclaimer

This package is not directly affiliated with Loqate. It is a third-party integration for the Loqate API in Flutter applications.
