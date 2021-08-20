import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:watherapp/Utils/constants.dart';
import 'package:watherapp/Utils/location_utils.dart';
import 'package:watherapp/Utils/network_helper.dart';
import 'package:watherapp/Utils/wathermodel.dart';
import 'package:watherapp/components/icon_button.dart';

import 'city_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weatherModel = WeatherModel();

  int temperature = 0;
  String weatherIcon = "";
  String cityName = "";
  String weatherMessage = "";

  @override
  void initState() {
    super.initState();

    //getLocationdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/img1.jpg",
          ),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButtonCustome(() {
                Constant.showLoaderDialog(context);
                getLocationdata();
              }, Icons.navigation),
              IconButtonCustome(() async {
                var typedName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CityScreen();
                    },
                  ),
                );
                if (typedName != null) {
                  Constant.showLoaderDialog(context);
                  getCityData(typedName);
                }
              }, Icons.apartment),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(21),
            child: Row(children: [
              Text(
                '$temperature°',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                weatherIcon,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(21),
            child: Text(
              '$weatherMessage in $cityName',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getLocationdata() async {
    LocationUtils locationUtils = LocationUtils();
    dynamic getLocationdata = await locationUtils.getLocation();

    if (getLocationdata.runtimeType == String) {
      print(getLocationdata);
      Navigator.pop(context);
    } else if (getLocationdata.runtimeType == LocationData) {
      LocationData locationData = getLocationdata;

      if (locationData.latitude != null) {
        String url = 'http://api.openweathermap.org/data/2.5/weather'
            '?lat=${locationData.latitude}&lon=${locationData.latitude}'
            '&appid=${Constant.apikey}&units=metric';
        NetWorkHelper helper = NetWorkHelper(url);
        print(url);
        setData(await helper.getResponseLocationData());
      }
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  getCityData(String cityname) async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=${Constant.apikey}&units=metric';
    print(url);
    NetWorkHelper helper = NetWorkHelper(url);
    setData(await helper.getResponseLocationData());
    Navigator.pop(context);
  }

  void setData(dynamic watherdata) {
    setState(() {
      print(jsonDecode(watherdata));
      dynamic json = jsonDecode(watherdata);
      double temp = json['main']['temp'];
      temperature = temp.toInt();

      var conodition = json['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(conodition);
      weatherMessage = weatherModel.getMessage(temperature);
      cityName = json['name'];
    });
  }
}
