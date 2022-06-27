class Weather {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
//if (response.statusCode == 200) {
      // data = response.body;
      // temp = jsonDecode(data)['current']['temp_c'];
      // region = jsonDecode(data)['location']['region'];

      // if (kDebugMode) {
      // print(region);
      // }
      // }