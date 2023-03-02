import 'dart:convert';

import 'package:http/http.dart';

void login(String email, password) async {
  try {
    Response response = await post(Uri.parse('base_url/login'),
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('Login successfully');
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
}
