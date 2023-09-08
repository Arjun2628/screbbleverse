import 'package:http/http.dart' as http;

class HttpService {
  static const baseUrl =
      "https://api.dictionaryapi.dev/api/v2/entries/"; // dictionary api key
  static const ebookUrl =
      "https://freebooksapi.pyaesonemyo.dev/api/latest/planetebooks/search?q=dostoyevsky&limit=1"; // ebooks api key

  static Future<http.Response> getRequest(String endPoint) async {
    final http.Response response;

    final url = Uri.parse("$baseUrl$endPoint");
    try {
      response = await http.get(url);
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<http.Response> getBooks() async {
    final http.Response response;

    final url = Uri.parse(ebookUrl);
    try {
      response = await http.get(url);
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
