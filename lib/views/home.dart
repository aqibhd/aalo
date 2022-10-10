import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import '../model/photo.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  Future<List<Photo>?> getPhotos() async {
    final String baseUrl = FlutterConfig.get('BASE_URL');
    final String apiAuth = FlutterConfig.get('API_AUTH');
    List<Photo>? photos = [];
    final Uri url =
        Uri.https(baseUrl, '/v1/curated', {'per_page': '80', 'page': '1'});
    try {
      var response = await http.get(url, headers: {'Authorization': apiAuth});
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in jsonDecode(response.body)['photos']) {
          photos.add(Photo.fromJson(i));
        }
        return photos;
      }
    } catch (e) {
      print(e.toString());
    }
    return photos = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemBuilder: (BuildContext context, int index) => Container(
                  color: Color(int.parse(
                      '0xff${(snapshot.data![index].avgColor).substring(1)}')),
                  child: CachedNetworkImage(
                    imageUrl: (snapshot.data![index]).src.tiny,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Center(
                  child: Text('Loading...',
                      style: TextStyle(color: Colors.white))),
            );
          }
        });
  }
}
