import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/parsing-json/PODO.dart';
import 'package:http/http.dart' as http;

class Json_Parsing extends StatefulWidget {
  const Json_Parsing({Key? key}) : super(key: key);

  @override
  _Json_ParsingState createState() => _Json_ParsingState();
}

class _Json_ParsingState extends State<Json_Parsing> {
  Future<PostList>? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.loadjson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("TODO")),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              List<Post>? allPosts;
              if (snapshot.hasData) {
                allPosts = snapshot.data?.posts;
                return Text("${allPosts?[0].title}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class Network {
  final String url;

  Network(this.url);
  Future<PostList> loadjson() async {
    final http.Response response =
        await http.get(Uri.parse(Uri.encodeFull(url)));
    if (response.statusCode == 200) {
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Not found..!!");
    }
  }
}
