import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '1502be0fbd2545a4a310bd30834a2f9e';
  final String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<dynamic>> fetchTeslaNews() async {
    final url = Uri.parse(
      '$baseUrl?q=tesla&from=2025-09-29&sortBy=publishedAt&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['articles'];
    } else {
      throw Exception('Ошибка при загрузке новостей: ${response.statusCode}');
    }
  }
}
