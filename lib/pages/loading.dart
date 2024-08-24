import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/worldtime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setuptime() async {
    WorldTime instance = WorldTime(url: 'Asia/Kolkata', flag: 'India.png', location: 'India');
    await instance.getdate();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isdaytime':instance.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();
    setuptime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitWaveSpinner(
          color: Colors.green,
          size: 100.0,
        ),
      ),
    );
  }
}