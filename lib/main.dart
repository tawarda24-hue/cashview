import 'package:flutter/material.dart';
void main() => runApp(CashViewApp());
class CashViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('CashView - 120 pts'), backgroundColor: Colors.deepPurple),
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('CashView خدام!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text('Banner: 7577911497'),
          Text('Interstitial: 8224778750'),
          Text('Rewarded: 4868434782'),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){}, child: Text('Daily Check-in - 10 pts')),
          ElevatedButton(onPressed: (){}, child: Text('عجلة الحظ - 50 pts')),
          ElevatedButton(onPressed: (){}, child: Text('بطاقة الحك')),
        ])),
      ),
    );
  }
}
