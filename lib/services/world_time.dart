import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      print('worldtimeapi.org/api/timezone/$url');
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url'); //.timeout(Duration(milliseconds: 10000));
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      print('time: $time');
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
