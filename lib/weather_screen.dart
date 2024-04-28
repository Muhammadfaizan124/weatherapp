import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/api.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  TextEditingController weatherSearch = TextEditingController();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: weatherSearch,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here...",
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              buildUI(),
            ],
          ),
        ),
      ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          dateTimeInfo(),
        ],
      ),
    );
  }

  //function to show current area name.
  Widget locationHeader() {
    return Text(
      weather?.areaName ?? "",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

//funtion to show current area's time.
  Widget dateTimeInfo() {
    return Column(
      children: [
        //this date format imported from intle package.
        //Time.
        Text(
          DateFormat("h:mm a").format(
            DateTime.now(),
          ),
          style: TextStyle(fontSize: 40),
        ),
        SizedBox(
          height: 10,
        ),
        //Day.
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(
                DateTime.now(),
              ),
              style: TextStyle(fontSize: 25),
            ),
            //Date.
            Text(
              "  ${DateFormat("d.m.y").format(
                DateTime.now(),
              )}",
              style: TextStyle(fontSize: 25),
            ),
          ],
        )
      ],
    );
  }

  //function to show weather Icon.
  Widget weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(weather?.weatherDescription ?? ""),
      ],
    );
  }

  //function to show current temperature.
  Widget currentTemp() {
    return Text(
      "${weather?.temperature?.celsius?.toStringAsFixed(0)}\u00B0C",
      style: TextStyle(),
    );
  }
}
