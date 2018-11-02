import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bean {
  final int userId;
  final int id;
  final String title;
  final String body;

  Bean({this.userId, this.id, this.title, this.body});

  factory Bean.fromJson(Map<String, dynamic> json) {
    return Bean(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<Bean> getBean() async {
  final response = await http.get(
      'https://jsonplaceholder.typicode.com/posts/1',
      headers: {HttpHeaders.userAgentHeader: 'MI-6'});

  if (response.statusCode == 200) {
    return Bean.fromJson(json.decode(response.body));
  } else {
    throw Exception('http get failure data');
  }
}

class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;

  Photo({this.id, this.title, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((p) => Photo.fromJson(p)).toList();
}

Future<List<Photo>> getPhotos(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/photos');

  return compute(parsePhotos, response.body);
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-http',
      home: Scaffold(
        appBar: AppBar(
          title: Text('MY HTTP'),
        ),
        body: Center(
          child: FutureBuilder(
            future: getPhotos(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data[index];
                      return Container(
                        height: 120.0,
                        child: Center(
                          child: Text(item.title),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
