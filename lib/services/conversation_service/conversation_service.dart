import 'dart:convert';
import 'package:http/http.dart' as http;

void conversation() async {
  try {
    final response = await http.get(Uri.parse('conversation'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('conversation successfully');
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
}
