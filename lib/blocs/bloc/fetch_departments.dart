import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchDepartments() async {
  try {
    final url = Uri.parse('https://api.novaposhta.ua/v2.0/json/');
    final apiKey = 'ba22a8412ccac3d90e60dbb019867c0a'; 

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "apiKey": apiKey,
        "modelName": "Address", // змінено з AddressGeneral
        "calledMethod": "getWarehouses",
        "methodProperties": {
          "CityName": "Київ", 
          "Limit": 1000
        }
      }),
    );

    print('Статус код: ${response.statusCode}');
    print('Тіло відповіді: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        final warehouses = data['data'] as List;
        print('Список відділень: ${warehouses.length}');
        List<String> warehouseList = warehouses
            .map((warehouse) => warehouse['Description'] as String? ?? '')
            .toList();
        print('Список: $warehouseList');
        return warehouseList;
      }
    }
    return [];
  } catch (e, stackTrace) {
    print('Помилка при отриманні відділень: $e');
    print('Stack trace: $stackTrace');
    return [];
  }
}