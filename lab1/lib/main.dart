import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
                      'assets/logo/logo.svg',
                      height: 30,
                    ),
                    const SizedBox(height: 200),
            Icon(Icons.notifications_none_outlined),
          ],
        )
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Expanded(child: Column(
          children: [
            Container(
              height:40,
              width:200,
              decoration: BoxDecoration(
                
              ),
              margin: EdgeInsets.all(10),
            )
          ],
        )),
      )
    );
  }
}
