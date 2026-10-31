import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
void main() => runApp(CashViewApp());
class CashViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int points = 0;
  String lastCheckIn = '';
  Random random = Random();
  @override
  void initState() {
    super.initState();
    loadPoints();
  }
  Future<void> loadPoints() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      points = prefs.getInt('points') ?? 0;
      lastCheckIn = prefs.getString('lastCheckIn') ?? '';
    });
  }
  Future<void> savePoints() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', points);
    await prefs.setString('lastCheckIn', lastCheckIn);
  }
  void dailyCheckIn() async {
    String today = DateTime.now().toString().split(' ')[0];
    if (lastCheckIn == today) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Already checked in today!')));
      return;
    }
    setState(() {
      points += 10;
      lastCheckIn = today;
    });
    await savePoints();
  }
  void wheelOfFortune() async {
    int reward = [10,20,30,40,50,100][random.nextInt(6)];
    setState(() { points += reward; });
    await savePoints();
    showDialog(context: context, builder: (context) => AlertDialog(title: Text('You won $reward pts!'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))]));
  }
  void scratchCard() async {
    int reward = 5 + random.nextInt(46);
    setState(() { points += reward; });
    await savePoints();
    showDialog(context: context, builder: (context) => AlertDialog(title: Text('You won $reward pts!'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))]));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CashView - $points pts'), backgroundColor: Colors.deepPurple),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('CashView - $points pts', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          ElevatedButton(onPressed: dailyCheckIn, child: Text('Daily Check-in - 10 pts')),
          ElevatedButton(onPressed: wheelOfFortune, child: Text('Wheel of Fortune')),
          ElevatedButton(onPressed: scratchCard, child: Text('Scratchcard')),
        ]),
      ),
    );
  }
}
