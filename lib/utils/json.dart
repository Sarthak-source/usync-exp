

import 'dart:convert';

bool isJson(String jsonString) {
  try {
    json.decode(jsonString) as Map<String, dynamic>;
  } catch (e) {
    return false;
  }
  return true;
}
