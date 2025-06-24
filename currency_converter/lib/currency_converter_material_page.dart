import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatelessWidget{
  const CurrencyConverterMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    //BuildContext - class that tells flutter the page in question is "here"
    // For instance here it states the location of this "CurrencyConverterMaterialPage" page

    //Every time you extend a stateless widget, you have acces to BuildContext
    //every widget extended by StatlessWidget will have its own build context (flutter wants to know its location)
    return const Scaffold(
        body: Center(
          child: Text("Hello Cousins!!"),
        
        )
      );
  }

}