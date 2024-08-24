import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'; // For JSON decoding
import 'package:intl/intl.dart';

class WorldTime {
  late String url;
  late String time;
  late String flag;
  late String location;
  late bool isDaytime;

  WorldTime({required this.url, required this.flag, required this.location});

  Future<void> getdate() async {
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Extracting datetime and offset information
      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(1, 3);
      String offset2 = data['utc_offset'].substring(4, 6);

      // Parsing datetime and adding the offset
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      // Checking if it is daytime
      isDaytime = now.hour > 6 && now.hour < 17;

      // Formatting the time
      time = DateFormat.jm().format(now);
    } catch (e) {
      if (kDebugMode) {
        print("error is $e");
      }
      time = 'Could not get the time';
    }
  }
}