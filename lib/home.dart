import 'package:consumindo_api/list_posts.dart';
import 'package:consumindo_api/bit_price.dart';
import 'package:consumindo_api/search_cep.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexNow = 0;
  final List<Widget> _screens = const [SearchCep(), BitPrice(), ListPosts()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumindo APIs'),
      ),
      body: _screens[indexNow],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexNow,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Busca CEP"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: "Preço Bitcoin"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Lista de Post"),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      indexNow = index;
    });
  }
}
