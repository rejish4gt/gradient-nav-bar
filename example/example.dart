import 'package:flutter/material.dart';
import 'package:gradient_nav_bar/gradient_nav_bar.dart';
import 'package:gradient_nav_bar/model/tab_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Custom Nav Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
 
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    var gradient = LinearGradient(
                colors: [Color(0xFFD602EE), Color(0x00D602EE)],//[Color.fromRGBO(254, 34, 164, 100), Color.fromRGBO(254, 34, 164, 0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              );
    var backgroundColor = Color(0xFF6002EE); // Color.fromRGBO(72, 31, 216, 1);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Add the gradient navigation bar here
      bottomNavigationBar: GradientNavigationBar(
        backgroundColor: backgroundColor,
        gradient: gradient,
        currentIndex: _selectedIndex, 
        iconColor: Colors.grey,
        labelColor: Colors.grey,
        selectedIconColor: Colors.white,
        onTap: _selectIndex, // calls a void method to change the index on tap of the item
        showLabel: true,
        items: [
          TabInfo(
            icon: Icons.ac_unit,
            label: 'AC Unit'
          ),
          TabInfo(
            icon: Icons.backup,
            label: 'Backup'
          ),
          TabInfo(
            icon: Icons.cached,
            label: 'Cached'
          ),
          TabInfo(
            icon: Icons.dashboard,
            label: 'Dashboard'
          ),
        ],
      ),
    );
  }

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
