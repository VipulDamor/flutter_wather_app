import 'package:http/http.dart' as http;

class NetWorkHelper {
  String url;

  NetWorkHelper(this.url);

  Future<dynamic> getResponseLocationData() async {
    var urlweb = Uri.parse(url);
    http.Response response = await http.get(urlweb);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return {response.statusCode, response.reasonPhrase};
    }
  }

  Future<dynamic> getResponseCityData() async {
    var urlweb = Uri.parse(url);
    http.Response response = await http.get(urlweb);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return {response.statusCode, response.reasonPhrase};
    }
  }
}
