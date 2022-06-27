import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ruso_chat/screens/userProfile.dart';
import 'dart:convert';

import 'package:ruso_chat/services/weather.dart';

const String openWapiKey = '38ed59cf8a4f837f27c530fd4da8888a';
const String weatherApiKey = "27772fd1271d4482aae144950221406";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);
  static const id = "screenid";

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

Weather weatherIcon = Weather();
double temp = 0.0;
String name = "";
String region = "";
int condition = 0;
String country = "";
String locatTime = "";
bool controler = true;
late double latitude;
late double longitude;

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  Future getWeatherData1() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$openWapiKey'));
      setState(
        () {
          var data = jsonDecode(response.body);
          condition = data['weather'][0]['id'];
        },
      );
    } catch (e) {}
  }

  Future getPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {}
  }

  Future getWeatherData2() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=$weatherApiKey&q=$latitude,$longitude'));
      setState(
        () {
          var data = jsonDecode(response.body);
          temp = data['current']['temp_c'];
          name = data['location']['name'];
          region = data['location']['region'];
          country = data['location']['country'];
          localtime = data['location']['localtime'];
        },
      );
    } catch (e) {}
  }

  @override
  void initState() {
    getWeatherData1();
    getPosition();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 1,
        ));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          controler = false;
        });
      });
    } catch (e) {}

    getWeatherData2();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/back2.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: Container(
              color: const Color.fromRGBO(256, 0, 0, 0.5),
              height: 300,
              width: 400,
              child: ModalProgressHUD(
                inAsyncCall: controler,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "To Day ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            localtime,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                temp.toInt().toString(),
                                style: const TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const Text(
                                "°C",
                                style: TextStyle(
                                    fontSize: 75,
                                    color: Color.fromARGB(255, 224, 180, 49)),
                              ),
                            ],
                          ),
                          Text(
                            weatherIcon.getWeatherIcon(condition),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _controller.value * 62,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.amber[400],
                          ),
                          Text(
                            "Selcuklu $name $region $country",
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
