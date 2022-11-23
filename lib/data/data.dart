import 'dart:convert';

import 'package:http/http.dart' as http;

final request =
    Uri.parse('https://api.hgbrasil.com/finance?format=json-cors&key=1dd7fc57');

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
