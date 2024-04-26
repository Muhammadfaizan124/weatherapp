import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/api.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  //to get weather from weather package.      API
  final WeatherFactory wf = WeatherFactory(weatherAPI);
  //to store info for the weather coming from weather API.
  Weather? weather;
  @override
  //this function send request to weather package to get info from
  //weather API and store in variable weather.
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("karachi").then((w) {
      setState(() {
        weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: buildUI(),
    );
  }

//function to build UI
  Widget buildUI() {
    if (weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        ],
      ),
    );
  }
}
