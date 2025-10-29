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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/logo/logo.svg',
              height: 30,
            ),
            const SizedBox(height: 200),
          ],
        ),
        actions: [            
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all( // Рамка (граница)
                color: Colors.white, 
              ),  
              boxShadow: [ 
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4, 
                offset: Offset(0, 2), 
              ),
            ],
            ),
            child: Icon(Icons.notifications_none_outlined),
          )
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Column(
          children: [
            Container(
              height:40,
              width:200,
              decoration: BoxDecoration(
                
              ),
              margin: EdgeInsets.all(10),
            )
          ],
        )
      ),
    );
  }
}
