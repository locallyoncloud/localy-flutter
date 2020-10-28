import 'dart:convert';

extension cloneObject on Map{
  Map get clone{
    final String jsonString = json.encode(this);
    final jsonResponse = json.decode(jsonString);
    return jsonResponse;
  }

}