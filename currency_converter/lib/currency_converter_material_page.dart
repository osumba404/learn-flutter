//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//1. Create a variable that stores the value to be converted
//2. Create a function that multiplies the value given by the textfield
//3. Store the value in a variable that we created
//4. display converted currency value

class CurrencyConverterMaterialPage extends StatefulWidget {
    const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() {
  return _CurrencyConverterMaterialPage();
  }
}

class _CurrencyConverterMaterialPage 
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("rebuild");
 
   

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
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 165, 221),
        title: const Text("Currency Converter", 
        style:TextStyle(
          color: Color.fromARGB(255, 0,  0, 255),           
        ),),
        actions: [
            Text("Hello")
          ],

          
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(0, 150, 255, 1),
       
        body: Center(
        child: Column(  //layout (top to botom), accepts children
        mainAxisAlignment: MainAxisAlignment.center, 
     
        children: [
          
          const Text("Convert to USD", 
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 0,  0, 255),
            ),
          ),

          Text(
            "\$ ${result.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 0,  0, 255),
            ),
          ),

            Padding(
              padding: EdgeInsets.all(6.0),
              child: TextField(
                controller: textEditingController,
                // onSubmitted:(value) {
                //   print(value);
                // },
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



            //Button
            //1. Raised button
            //2. Apears like a text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                     result = double.parse(textEditingController.text)/129.28;
                  });

                 
                  // print(textEditingController.text);
                  // print(double.parse(textEditingController.text)/129.28);
                // if(kDebugMode) {                
                // print("Button clicked");
                // }
              }, 
              style:  ButtonStyle(
                elevation: const MaterialStatePropertyAll(5),
                backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 54, 165, 221)),
                foregroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 0,  0, 255)),
                minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 50)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(8)
                  )),
              ),
              child: const Text("Convert")),
            ),
            
        ],
        )) 
      );
  }
}

// class CurrencyConverterMaterialPagee extends StatelessWidget{
//   const CurrencyConverterMaterialPagee({super.key});






//} 