import 'dart:convert';
import 'package:consumindo_api/post.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListPosts extends StatefulWidget {
  const ListPosts({Key? key}) : super(key: key);

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  String urlBase = 'https://jsonplaceholder.typicode.com';
  String msg = '';

  Future<List<Post>> _searchPost() async {
    http.Response response;
    response = await http.get(Uri.parse(urlBase + '/posts'));
    var dataJason = jsonDecode(response.body);

    List<Post> posts = [];
    for (var post in dataJason) {
      Post p = Post(post['userId'], post['id'], post['title'], post['body']);
      posts.add(p);
    }
    return posts;
  }

  _post() async {
    Post post = Post(120, null, 'Titulo', 'Corpo');

    var body = jsonEncode(post.toJson());

    http.Response response = await http.post(Uri.parse(urlBase + '/posts'),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: body);

    print(response.statusCode);
    print(response.body);
  }

  _put() async {
    Post post = Post(120, null, 'Titulo - Editado', 'Corpo - Editado');

    var body = jsonEncode(post.toJson());

    http.Response response = await http.put(Uri.parse(urlBase + '/posts/2'),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: body);

    print(response.statusCode);
    print(response.body);
  }

  _delete() async {
    http.Response response = await http.delete(Uri.parse(urlBase + '/posts/2'));

    print(response.statusCode);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(100, 40)),
                  onPressed: _post,
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(100, 40)),
                    onPressed: _put,
                    child: const Text(
                      'Atualizar',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: const Size(100, 40)),
                  onPressed: _delete,
                  child: const Text(
                    'Remover',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _searchPost(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        msg = 'Erro ao carregar dados';
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            List<Post>? list = snapshot.data;
                            Post post = list![index];
                            return ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.body),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        );
                      }
                      break;
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.active:
                    case ConnectionState.none:
                  }
                  return Text(
                    msg,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  );
                },
              ),
            )
          ],
        ));
  }
}
