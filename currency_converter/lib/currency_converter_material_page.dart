import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatelessWidget{
  const CurrencyConverterMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Color.fromARGB(255, 41, 19, 19),
                     width: 2,
                     style: BorderStyle.solid,
                     strokeAlign:BorderSide.strokeAlignCenter,                     
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                );
    //BuildContext - class that tells flutter the page in question is "here"
    // For instance here it states the location of this "CurrencyConverterMaterialPage" page

    //Every time you extend a stateless widget, you have acces to BuildContext
    //every widget extended by StatlessWidget will have its own build context (flutter wants to know its location)
    return const Scaffold(
      backgroundColor: Color.fromRGBO(0, 150, 255, 1),
        body: Center(
        child: Column(  //layout (top to botom), accepts children
        mainAxisAlignment: MainAxisAlignment.center, 
       
        children: [
          Text("Debug Mode!", 
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 0,  0, 255),
          ),),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  //   helper: Text("Enter amount in KES", style: TextStyle(
                  //   color: Color.fromARGB(255, 0,  0, 255),
                  // )
                  hintText: "Enter amount in KES",
                  hintStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  prefixIcon: Icon((Icons.monetization_on_outlined)), 
                  prefixIconColor: Colors.white70,  
              
                  // suffixIcon: Icon((Icons.monetization_on_outlined)), 
                  // suffixIconColor: Colors.white70, 
                  filled: true,
                  fillColor: Color.fromRGBO(0, 170, 255, 1),   
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                       color: Color.fromARGB(255, 41, 19, 19),
                       width: 2,
                       style: BorderStyle.solid,
                       strokeAlign:BorderSide.strokeAlignCenter,                     
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  enabledBorder: OutlineInputBorder(                
                    borderSide: BorderSide(
                       color: Color.fromARGB(255, 41, 19, 19),
                       width: 2,
                       style: BorderStyle.solid,
                       strokeAlign:BorderSide.strokeAlignCenter,                     
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
        ],
        )) 
      );
  }

} 