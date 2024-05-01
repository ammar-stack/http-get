import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_10/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

List<PostModel> postlist = [];

  Future<List<PostModel>> getPostAPI() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    }
    else{
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade400,
              title: const Text("API"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: getPostAPI(), 
                    builder: ((context, snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: Text("LOADING"));
                      }
                      else{
                        return ListView.builder(
                          itemCount: postlist.length,
                          itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Title\n"+postlist[index].title.toString()),
                                  Text("Body\n"+postlist[index].body.toString())
                                ],
                              ),
                            ),
                          );
                        });
                      }
                    })),
                )
              ],
            )));
  }
}
