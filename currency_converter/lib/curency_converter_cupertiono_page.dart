import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Only needed for colors and possibly fallback support

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() => _CurrencyConverterCupertinoPageState();
}

class _CurrencyConverterCupertinoPageState extends State<CurrencyConverterCupertinoPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("rebuild");

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey3,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey3,
        middle: Text("Currency Converter"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Convert to USD",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.activeBlue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\$ ${result.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.activeGreen,
                ),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: textEditingController,
                keyboardType: TextInputType.number,
                placeholder: "Enter amount in KES",
                prefix: const Icon(CupertinoIcons.money_dollar_circle),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: CupertinoColors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                    width: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                child: const Text("Convert"),
                onPressed: () {
                  setState(() {
                    final input = textEditingController.text;
                    if (input.isNotEmpty) {
                      result = double.tryParse(input) != null
                          ? double.parse(input) / 129.28
                          : 0.0;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
