import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class University {
  String name;
  String website;
  University({required this.name, required this.website});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  late Future<List<University>> futureUniversities;

  // API endpoint
  String url = "http://universities.hipolabs.com/search?country=Indonesia";

  // Fetch data from API
  Future<List<University>> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<University> universities = [];
      data.forEach((university) {
        universities.add(University(
          name: university['name'],
          website: university['web_pages'][0],
        ));
      });
      return universities;
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureUniversities = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Universitas Indonesia',
      home: Scaffold(
        appBar: AppBar(
          title: Text('List Universitas di Indonesia'),
        ),
        body: Center(
          child: FutureBuilder<List<University>>(
            future: futureUniversities,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            snapshot.data![index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.data![index].website,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                    );
                  },
                );
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
