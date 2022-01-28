import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ax = 0, ay = 0, az = 0;
  double top = 175;
  double left = 175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ax.toString()),
            Text(ay.toString()),
            Text(az.toString()),
            Text(text()),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              child: Stack(children: [
                AnimatedPositioned(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                  duration: const Duration(milliseconds: 500),
                  top: top,
                  left: left,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((event) {
      setState(() {
        ax = event.x;
        ay = event.y;
        az = event.z;
      });
    });
  }

  String text() {
    if (ay.abs() > ax.abs()) {
      if (ay < -3) {
        if (top >= 30) top -= 30;
        return "UP";
      } else if (ay > 3) {
        top += 30;
        return "Down";
      }
    } else {
      if (ax < -3) {
        left++;
        return "Right";
      } else if (ax > 3) {
        left--;
        return "Left";
      }
    }

    return "Center";
  }
}
