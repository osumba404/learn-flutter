import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:asure_sky/weather_service.dart';
import 'package:asure_sky/weather_hr_forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "ASURE SKY",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
              Colors.lightBlue.shade600,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 20),
                
                // MAIN CARD
                const _MainWeatherCard(),

                const SizedBox(height: 30),


                // WEATHER FORECAST
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("HOURLY FORECAST",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        )),
                  ),
                ),
           
                const SizedBox(height: 12),
                const HourlyForecastList(),

                const SizedBox(height: 30),

                // ADDITIONAL INFO
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("WEATHER DETAILS",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        )),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: const [
                    AdditionalInfoCard(
                        title: "HUMIDITY", value: "78%", icon: Icons.water_drop),
                    AdditionalInfoCard(
                        title: "WIND", value: "12 km/h", icon: Icons.air),
                    AdditionalInfoCard(
                        title: "PRESSURE", value: "1013 hPa", icon: Icons.speed),
                    AdditionalInfoCard(
                        title: "VISIBILITY", value: "10 km", icon: Icons.visibility),
                    AdditionalInfoCard(
                        title: "WIND DIR", value: "NE", icon: Icons.explore),
                    AdditionalInfoCard(
                        title: "UV INDEX", value: "6", icon: Icons.wb_sunny),
                  ],
                ),

                const SizedBox(height: 30),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("LOCATION & TIME",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        )),
                  ),
                ),
                const SizedBox(height: 12),
                const LiveLocationSection(),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// MAIN WEATHER CARD
class _MainWeatherCard extends StatefulWidget {
  const _MainWeatherCard({super.key});

  @override
  State<_MainWeatherCard> createState() => _MainWeatherCardState();
}

class _MainWeatherCardState extends State<_MainWeatherCard> {
  Map<String, dynamic>? weatherData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final data = await WeatherService.fetchWeather(position.latitude, position.longitude);
      setState(() {
        weatherData = data;
        loading = false;
      });
    } catch (e) {
      print("Weather API error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || weatherData == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    final temp = weatherData!['main']['temp'].toString();
    final condition = weatherData!['weather'][0]['main'];
    final feelsLike = weatherData!['main']['feels_like'].toString();
    final location = weatherData!['name'];

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_pin, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(location,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Text("Today, ${DateFormat('MMMM d').format(DateTime.now())}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                )),
            const SizedBox(height: 20),

            // Temperature
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.white, Colors.lightBlue.shade200],
                stops: const [0.3, 1.0],
              ).createShader(bounds),
              child: Text("$temp°C",
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),

            // Weather Icon + Text
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                const Icon(Icons.cloud, size: 70, color: Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Text(condition,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                )),
            const SizedBox(height: 10),
            Text("Feels like $feelsLike°C",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                )),
          ],
        ),
      ),
    );
  }
}


class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String temp;
  final String iconCode;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.temp,
    required this.iconCode,
  });

  String getIconUrl(String code) => 'https://openweathermap.org/img/wn/$code@2x.png';

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Text(time,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              )),
          const SizedBox(height: 12),
          Image.network(
            getIconUrl(iconCode),
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 12),
          Text(temp,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              )),
        ],
      ),
    );
  }
}

class HourlyForecastList extends StatefulWidget {
  const HourlyForecastList({super.key});

  @override
  State<HourlyForecastList> createState() => _HourlyForecastListState();
}

class _HourlyForecastListState extends State<HourlyForecastList> {
  List<Map<String, dynamic>> hourlyData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHourlyForecast();
  }

  Future<void> _loadHourlyForecast() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final data = await HourlyWeatherService.fetchHourlyForecast(position.latitude, position.longitude);
      setState(() {
        hourlyData = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading hourly forecast: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: hourlyData.map((hour) {
          final dt = DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000);
          final time = DateFormat('HH:mm').format(dt);
          final temp = hour['temp'].toStringAsFixed(1);
          final weatherIcon = hour['weather'][0]['icon'];

          return HourlyForecastCard(
            time: time,
            temp: '$temp°C',
            iconCode: weatherIcon,
          );
        }).toList(),
      ),
    );
  }
}



class AdditionalInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AdditionalInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: 110,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
                letterSpacing: 1.1,
              )),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}

// LIVE LOCATION SECTION
class LiveLocationSection extends StatefulWidget {
  const LiveLocationSection({super.key});
  @override
  State<LiveLocationSection> createState() => _LiveLocationSectionState();
}

class _LiveLocationSectionState extends State<LiveLocationSection> {
  Position? _currentPosition;
  String _time = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _getLocation();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    setState(() {
      _time = formatted;
    });
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permissions are denied.');
      }
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
                child: const Icon(Icons.location_on, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                "LIVE LOCATION",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _currentPosition != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Latitude", _currentPosition!.latitude.toStringAsFixed(4)),
                    _buildInfoRow("Longitude", _currentPosition!.longitude.toStringAsFixed(4)),
                    _buildInfoRow("Accuracy", "${_currentPosition!.accuracy.toStringAsFixed(1)} m"),
                    _buildInfoRow("Time", _time),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.white.withOpacity(0.3)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _getLocation,
              child: const Text("REFRESH LOCATION"),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Glass Card Widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
