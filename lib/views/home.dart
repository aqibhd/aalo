import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:aalo/widgets/overlay_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import '../model/photo.dart';
import 'more.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  Future<List<Photo>?> getPhotos() async {
    final String baseUrl = FlutterConfig.get('BASE_URL');
    final String apiAuth = FlutterConfig.get('API_AUTH');
    List<Photo>? photos;
    final Uri url =
        Uri.https(baseUrl, '/v1/curated', {'per_page': '80', 'page': '1'});
    try {
      var response = await http.get(url, headers: {
        'Authorization': apiAuth
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        photos ??= [];
        for (Map<String, dynamic> i in jsonDecode(response.body)['photos']) {
          photos.add(Photo.fromJson(i));
        }
      }
    } on TimeoutException catch (_) {
      throw ('Timeout !');
    } on SocketException catch (_) {
      throw ("No Internet");
    } catch (e) {
      throw (e.toString());
    }
    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: getPhotos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: const Center(
                      child: Text('Loading...',
                          style: TextStyle(color: Colors.white))),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: Colors.white),
                  ));
                } else if (snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 130,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
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
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
        OverlayAppBar(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [AdditionalResourceButton()],
          ),
        ))
      ],
    );
  }
}

class AdditionalResourceButton extends StatelessWidget {
  const AdditionalResourceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const AdditionalResource())),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.8),
            ),
            child: Center(
                child: SvgPicture.asset(
              'assets/svg/list.svg',
              width: 16,
              height: 16,
            )),
          ),
        ),
      ),
    );
  }
}
