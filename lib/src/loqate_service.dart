import 'dart:convert';
import 'package:http/http.dart' as http;

class LoqateService {
  final String apiKey;

  LoqateService({required this.apiKey});

  // Method to search for address suggestions, now accepts countryCode
  Future<List<Map<String, String>>> searchAddress(String query, String countryCode) async {
    final String url =
        'https://api.addressy.com/Capture/Interactive/Find/v1.10/json3.ws?Key=$apiKey&Text=$query&IsMiddleware=false&Language=en-gb&Limit=10&Countries=$countryCode';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['Items'] != null) {
        return List<Map<String, String>>.from(data['Items'].map((item) => {
          'Text': item['Text'] as String,
          'Description': item['Description'] as String,
          'Id': item['Id'] as String,
          'Type': item['Type'] as String, // Include the type here
        }));
      }
    }
    throw Exception('Failed to load address suggestions');
  }

  // Method to get detailed address information based on the selected Id
  Future<Map<String, String>> getAddressDetails(String id) async {
    final String url =
        'https://api.addressy.com/Capture/Interactive/Retrieve/v1.20/json3.ws?Key=$apiKey&Id=$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Detailed API Response: $data");

      if (data['Items'] != null && data['Items'].isNotEmpty) {
        final item = data['Items'][0];

        return {
          'unitOrFlatNo': item['SubBuilding'] ?? '', // Assuming SubBuilding contains unit/flat info
          'streetNumber': item['BuildingNumber'] ?? '',
          'streetName': item['Street'] ?? '',
          'suburb': item['Neighbourhood'] ?? item['District'] ?? '', // Using Neighbourhood or District for suburb
          'city': item['City'] ?? '',
          'state': item['Province'] ?? '',
          'postalCode': item['PostalCode'] ?? '',
        };
      }
    }
    throw Exception('Failed to load address details');
  }
}
