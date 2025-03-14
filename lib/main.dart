
import 'package:flutter/material.dart'; 
import 'package:bitcoin/cion.dart'; 
import 'package:bitcoin/network.dart'; 
import 'package:flutter_spinkit/flutter_spinkit.dart'; 

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mycoinstless(),
  ));
}

class Mycoinstless extends StatefulWidget {
  const Mycoinstless({super.key});

  @override
  State<Mycoinstless> createState() => _MycoinstlessState();
}

class _MycoinstlessState extends State<Mycoinstless> {
  double btcPrice = 0.0; // Changed to double

  @override
  void initState() {
    super.initState();
    getBitcoinPrice();
  }

  Future<void> getBitcoinPrice() async {
    double price = await CoinService().getBitcoinPrice1("bitcoin","usd");
    

    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => MyCoin(price),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitCircle(
        color: Colors.blue,
        size: 22,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
