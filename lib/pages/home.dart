import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // Check if arguments were passed, otherwise use default values
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    // Use null-aware access to avoid errors if the keys do not exist
    String location = data['location'] ?? 'Unknown';
    String time = data['time'] ?? 'Loading...';
    bool isDaytime = data['isdaytime'] ?? true;

    // Use actual Color objects
    Color bgColor = isDaytime ? Colors.blue[700]! : Colors.black;
    String bgImage = isDaytime ? 'day.webp' : 'asshole.jpg';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic res = await Navigator.pushNamed(context, '/location');
                    if (res != null) {
                      setState(() {
                        data = {
                          'time': res['time'] ?? 'Loading...',
                          'location': res['location'] ?? 'Unknown',
                          'isdaytime': res['isdaytime'] ?? true,
                          'flag': res['flag'],
                        };
                      });
                    }
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text("Choose Location"),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}