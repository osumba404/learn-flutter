import 'package:currency_converter/currency_converter_material_page.dart';
import 'package:flutter/material.dart'; // imports all flutter related stuff

void main() {
  runApp(const MyApp()); //adding const says the widget MyApp does not need to ba created every time
}

//Widgets are just classes
//Widgets types in UI
//1. StatelessWidget - app will have less state, data is immutable (cant be changed once created)
//2. StatefulWidget - data is mutable (state can change)

//State - Some data that your widget will care about
//Stateless

class MyApp extends StatelessWidget {    //need to extend to StatlessWidget to make MyApp a widget
  const MyApp({super.key});


// Flutter app designs
//1. Material Design (by google)
//2. Cupertino Design (by apple)
  @override
  Widget build(BuildContext context){
    //return const Text(
     // "Hi Cousins", 
     // textDirection: TextDirection.ltr,);    //Widgets - building blocks of the UI, describe what UI looks like. TextDirection - dictates where a text will be displayed
    return MaterialApp(
      home: CurrencyConverterMaterialPage(),
    );
  }
}