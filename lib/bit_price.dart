import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BitPrice extends StatefulWidget {
  const BitPrice({Key? key}) : super(key: key);

  @override
  _BitPriceState createState() => _BitPriceState();
}

class _BitPriceState extends State<BitPrice> {
  String priceBit = '';

  _bitPriceNow() async {
    http.Response response;
    response = await http.get(Uri.parse(
      'https://blockchain.info/ticker',
    ));
    Map<String, dynamic> request = jsonDecode(response.body);
    setState(() {
      priceBit = request['BRL']['buy'].toStringAsFixed(2);
    });
  }

  @override
  // ignore: must_call_super
  initState() {
    _bitPriceNow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BitPrice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bitcoin.png',
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'R\$ $priceBit',
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(150, 50)),
                onPressed: _bitPriceNow,
                child: const Text(
                  'Atualizar',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
