import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:qweather_icons/qweather_icons.dart';

import 'package:weather_app/forecastapi.dart';
import 'package:weather_app/model/forecast_weather_model.dart';
import 'package:weather_app/weatherapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final double temperatureInFahrenheit = 85;
  @override
  void initState() {
    super.initState();
    Provider.of<Weatheritems>(context, listen: false).fetchdata();
    Provider.of<Forecastitems>(context, listen: false).fetchdata();
  }

  DateTime timeZoneToTime(dynamic timezoneOffsetSeconds) {
    // Timezone offset from OpenWeatherMap API (in seconds)

    // Create a Duration with the given offset
    Duration offsetDuration = Duration(seconds: timezoneOffsetSeconds);

    // Get the current UTC time
    DateTime utcTime = DateTime.now().toUtc();

    // Apply the offset to get the local time
    DateTime localTime = utcTime.add(offsetDuration);
    return localTime;
  }

  //To convert MillisecondsSinceEpoch to DateTime
  DateTime? unpackDate(dynamic k) {
    int millis = k * 1000;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  String formatDate2(dynamic date) {
    String formattedDate = DateFormat('hh:mm').format(date);
    return formattedDate;
  }

  String formatDate(dynamic date) {
    String formattedDate = DateFormat('E d, y').format(date);
    return formattedDate;
  }

  String formatDateday(dynamic date) {
    String formattedDate = DateFormat('E').format(date);
    return formattedDate;
  }

  int convertToFahrenheit(double fahrenheit) {
    return ((fahrenheit - 32) * 5 / 9).round();
  }

  @override
  Widget build(BuildContext context) {
    final weatherdetails = Provider.of<Weatheritems>(context, listen: true);
    final forecastdetails = Provider.of<Forecastitems>(context, listen: true);
    // String formattedTemperature =
    //     formatFahrenheitToCelsius(temperatureInFahrenheit);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 104, 102, 102),
        Color.fromARGB(255, 112, 108, 108),
        Color.fromARGB(255, 135, 130, 130),
        Color.fromARGB(255, 192, 184, 184)
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: weatherdetails.weatherdatas == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                // decoration: const BoxDecoration(
                //     color: Color.fromARGB(255, 169, 179, 186)),
                child: Column(
                  children: [
                    SizedBox(
                      child: Text(
                        "Weather Forecast",
                        style: GoogleFonts.outfit(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "${convertToFahrenheit(weatherdetails.weatherdatas!.main.temp)}\u00B0c",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        weatherdetails.weatherdatas!.name,
                        style: GoogleFonts.gildaDisplay(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 39, 33, 33),
                                fontSize: 25)),
                      ),
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    // SizedBox(
                    // child: Text(
                    // weatherdetails.weatherdatas!.dt.toString(),
                    //style:
                    //  const TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
                    //),
                    //),
                    const SizedBox(height: 5),

                    Text(
                      "${formatDate2(timeZoneToTime(weatherdetails.weatherdatas!.timezone))} , ${formatDate(unpackDate(weatherdetails.weatherdatas!.dt))}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),

                    // //"${(timeZoneToTime(weatherdetails.weatherdatas!.timezone))}",

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 171, 162, 162),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topRight: Radius.elliptical(8, 8),
                                bottomLeft: Radius.elliptical(8, 8))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: 100,
                                decoration: const BoxDecoration(
                                    // color: Color.fromARGB(255, 82, 85, 86),
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    weatherdetails
                                        .weatherdatas!.weather[0].main,
                                    style: GoogleFonts.lexendExa(
                                        textStyle:
                                            const TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Image.network(
                                "https://openweathermap.org/img/wn/${weatherdetails.weatherdatas!.weather[0].icon}@2x.png",
                                height: 90,
                                width: 90,
                                color: const Color.fromARGB(255, 113, 109, 109),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),

                              Text(
                                "${convertToFahrenheit(weatherdetails.weatherdatas!.main.temp)}\u00B0c",
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "ADDITIONAL INFORMATION",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 39, 33, 33),
                                      fontSize: 20)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Today's Forecast",
                              // formatDateday(unpackDate(
                              // forecastdetails.forecastdatas!.list[0].dt)

                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 150,
                        child: forecastdetails.forecastdatas == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Consumer<Forecastitems>(
                                builder: (context, data, child) {
                                  DateTime currentDate = DateTime.now();

                                  List<ListElement> forecastData =
                                      data.forecastdatas!.list;

                                  List<ListElement> currentDayForecast =
                                      forecastData
                                          .where((forecast) =>
                                              forecast.dtTxt.year ==
                                                  currentDate.year &&
                                              forecast.dtTxt.month ==
                                                  currentDate.month &&
                                              forecast.dtTxt.day ==
                                                  currentDate.day)
                                          .toList();

                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: currentDayForecast.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 180,
                                          width: 120,
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 171, 162, 162),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topRight:
                                                      Radius.elliptical(8, 8),
                                                  bottomLeft:
                                                      Radius.elliptical(8, 8))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                // Text(forecastdetails
                                                //     .forecastdatas!.list[0].main.temp
                                                //     .toString()),
                                                Center(
                                                  child: Text(
                                                    currentDayForecast[index]
                                                        .dtTxt
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Center(
                                                  child: Text(
                                                    "${convertToFahrenheit(currentDayForecast[index].main.temp)} \u00B0C",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                //
                                                Image.network(
                                                  "https://openweathermap.org/img/wn/${currentDayForecast[index].weather[0].icon}@2x.png",
                                                  height: 42,
                                                  width: 45,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
