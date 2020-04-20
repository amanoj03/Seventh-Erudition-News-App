import 'package:flutter/material.dart';
import 'package:seventh_erudition/views/home.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() =>  runApp(MyApp());
/*
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Seventh Erudition",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Baloo Bhaina 2',
      ),
      home: Home(),
    ); 
  }

}
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) {
        return ThemeData(
            primaryColor: Colors.blueGrey,
            fontFamily: 'Baloo Bhaina 2',
            brightness: brightness == Brightness.light
                ? Brightness.light
                : Brightness.dark,
            scaffoldBackgroundColor: brightness == Brightness.dark
                ? Colors.blueGrey[900]
                : Colors.white);
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: "Seventh Erudition",
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Home(),
        );
      },
    );
  }
}