import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  _ExampleTwoState createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    print(data);
    if (response.statusCode == 200) {
      photoList.clear();
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'] , id: i['id']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Second Example'),
      ),
      body: Column(



        children: [
          Expanded(
            child: FutureBuilder(

                future: getPhotos(),
                builder: (context,AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          title : Text('ID : ' + snapshot.data![index].id.toString()),

                          subtitle: Text(snapshot.data![index].title.toString()),

                        );
                      });
                }),
          ),

          // Expanded(
          //   child: FutureBuilder(
          //       future: getPhotos(),
          //       builder: (context,AsyncSnapshot<List<Photos>> snapshot) {
          //         return ListView.builder(
          //             itemCount: photoList.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 leading: CircleAvatar(
          //                   backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
          //                 ),
          //                 title: Text(snapshot.data![index].title.toString()),
          //
          //               );
          //             });
          //       }),
          // ),


        ],
      ),
    );
  }
}

class Photos {
  String title, url;

  int id;

  Photos({required this.title, required this.url , required this.id});
}
