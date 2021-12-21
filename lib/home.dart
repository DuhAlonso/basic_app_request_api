import 'dart:convert';
import 'package:consumindo_api/bit_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cepController = TextEditingController();

  String logradouro = '';
  String bairro = '';
  String localidade = '';
  String msg = 'Digite o cep e clique em buscar';

  _searchCEP() async {
    String cep = _cepController.text;
    String urlApi = 'https://viacep.com.br/ws/$cep/json';
    http.Response response;
    response = await http.get(Uri.parse(urlApi));
    Map<String, dynamic> request = jsonDecode(response.body);

    if (response.statusCode == 200 && cep != '' && cep != '00000000') {
      setState(() {
        logradouro = request['logradouro'];
        bairro = request['bairro'];
        localidade = request['localidade'];
        msg = 'Seu endereço é: $logradouro, $bairro - $localidade ';
      });
    } else {
      setState(() {
        msg = 'CEP Inválido';
      });
      throw Exception('Erro no retorno dos dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumindo API VIACEP'),
      ),
      body: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BitPrice(),
              ),
            );
          },
          child: const Icon(
            Icons.monetization_on_outlined,
            size: 50,
          )),
    );
  }
}
