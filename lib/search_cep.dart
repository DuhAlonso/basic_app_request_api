import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SearchCep extends StatefulWidget {
  const SearchCep({Key? key}) : super(key: key);

  @override
  _SearchCepState createState() => _SearchCepState();
}

class _SearchCepState extends State<SearchCep> {
  final TextEditingController _cepController = TextEditingController();

  String logradouro = '';
  String bairro = '';
  String localidade = '';
  String msg = 'Digite o cep e clique em buscar';

  _searchCEP() async {
    String cep = _cepController.text;

    if (cep.length < 8) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            titleTextStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            content: Text('CEP inválido! Tente utilizar um CEP válido.'),
            contentTextStyle: TextStyle(fontSize: 20, color: Colors.black),
          );
        },
      );
    } else {
      String urlApi = 'https://viacep.com.br/ws/$cep/json';
      http.Response response;
      response = await http.get(Uri.parse(urlApi));
      Map<String, dynamic> request = jsonDecode(response.body);
      if (request['logradouro'] != null) {
        setState(() {
          logradouro = request['logradouro'];
          bairro = request['bairro'];
          localidade = request['localidade'];
          msg = 'Seu endereço é: $logradouro, $bairro - $localidade ';
        });
      } else if (request['erro'].toString() == 'true') {
        setState(() {
          msg = 'CEP inválido! Tente utilizar um CEP válido.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: const InputDecoration(
                label: Text('CEP'),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10),
              child: TextButton(
                onPressed: _searchCEP,
                child: const Text(
                  'Buscar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}
