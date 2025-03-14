import 'dart:io' show Platform;
import 'package:bitcoin/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCoin extends StatefulWidget {
  final double data;

  MyCoin(this.data);

  @override
  State<MyCoin> createState() => _MyCoinState();
}

class _MyCoinState extends State<MyCoin> {
  String? selectedValue;
  // ignore: non_constant_identifier_names
  double BtcUd = 0.0;
  // ignore: non_constant_identifier_names
  double Eth = 0.0;
  // ignore: non_constant_identifier_names
  double Cadrdon = 0.0;
  // ignore: non_constant_identifier_names
  double Bnb = 0.0; // Bitcoin price in selected currency

  // Currency Symbols Map
  Map<String, String> currencySymbols = {
    "AUD": "A\$",
    "CAD": "\$",
    "CHF": "CHF",
    "CNY": "¥",
    "EUR": "€",
    "GBP": "£",
    "HKD": "HK\$",
    "INR": "₹",
    "JPY": "¥",
    "KRW": "₩",
    "MXN": "\$",
    "NZD": "NZ\$",
    "RUB": "₽",
    "SAR": "ر.س",
    "SGD": "S\$",
    "THB": "฿",
    "TRY": "₺",
    "USD": "\$",
    "ZAR": "R"
  };

  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }

  void updateUI(double data) {
    setState(() {
      BtcUd = data;
    });
  }

  // Fetch Bitcoin price based on selected currency
  Future<void> fetchBitcoinPrice(String currency) async {
    double price = await CoinService().getBitcoinPrice1('bitcoin', currency);
    double priceE = await CoinService().getBitcoinPrice1("ethereum", currency);
    double priceBNb =
        await CoinService().getBitcoinPrice1("binancecoin", currency);
    double priceCar = await CoinService().getBitcoinPrice1("cardano", currency);
    setState(() {
      BtcUd = price;
      Eth = priceE;
      Cadrdon = priceCar;
      Bnb = priceBNb; // Update the displayed price
    });
  }

  Widget getPlatForm() {
    if (Platform.isIOS) {
      return IOS();
    } else {
      return android();
    }
  }

  DropdownButton<String> android() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currencySymbols.keys) {
      items.add(
        DropdownMenuItem<String>(
          value: currency,
          child: Text(currency, style: const TextStyle(color: Colors.white)),
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedValue,
      dropdownColor: Colors.black,
      hint: const Text(
        "Select a currency",
        style: TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.white,
      autofocus: true,
      items: items,
      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
        });
        if (value != null) {
          fetchBitcoinPrice(value); // Fetch price based on selection
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  CupertinoPicker IOS() {
    List<Text> items = [];

    for (String currency in currencySymbols.keys) {
      items.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedValue = currencySymbols.keys.toList()[index];
        });
        fetchBitcoinPrice(selectedValue!); // Fetch price based on selection
      },
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            "Exchange App",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "1 BIT = ${BtcUd.toStringAsFixed(2)} ${currencySymbols[selectedValue] ?? '\$'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "1 ETH = ${Eth.toStringAsFixed(2)} ${currencySymbols[selectedValue] ?? '\$'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "1 Cardano = ${Cadrdon.toStringAsFixed(4)} ${currencySymbols[selectedValue] ?? '\$'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "1 BNB = ${Bnb.toStringAsFixed(4)} ${currencySymbols[selectedValue] ?? '\$'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex:1),
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(1),
                ),
                height: 100,
                child: Center(child: Platform.isIOS? IOS():android())),
          ),
        ],
      ),
    );
  }
}
