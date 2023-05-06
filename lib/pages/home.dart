import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:wallpaper_application/pages/fullscreen.dart';
import 'package:wallpaper_application/widget/customappbar.dart';
import 'package:wallpaper_application/widget/searchbar.dart';

import '../models/photos_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];

  Future getImages({String? wallpaperName}) async {
    Uri url = Uri.parse('https://api.pexels.com/v1/curated?per_page=80');

    http.Response response = await http.get(url, headers: {
      'Authorization':
          '2IHqwxZovR7MsF8UPJTjtPlWJcPj8RoJblhscrY4OOs1RAaIqTYyDvyl'
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    setState(() {
      images = data['photos'];
    });

    // List<dynamic> d = data['photos'];

    print(images[0]);
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: "Wallpaper",
          word2: "App",
        ),
      ),
      body: Column(
        children: [
          SearchBar(),
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                    imageurl: images[index]['src']['large2x'],
                                  )));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                  child:
                  Container(
                    child: Image.network(
                      images[index]['src']['tiny'],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
