import 'package:flutter/material.dart';
import 'package:saadbarhounassesment/Models/detailsModesl.dart';
import 'package:saadbarhounassesment/Models/model.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saadbarhounassesment/detailsScreen.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyApp> {
  List<NFTModelDetails> nftArray = [];
  List<NFTModel> idsArray = [];
  String baseApi = 'https://pro-api.coingecko.com/api/v3/';
  final Dio _dio = Dio();
  late ScrollController controller;
  bool notFound = false;
  bool isLoading = false;

  // bool notFound = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Learn saad',
            style: TextStyle(color: Colors.white),
          ),
          actions: [],
        ),
        body: notFound
            ? const Center(
                child: Text('No Data Found', style: TextStyle(fontSize: 30)),
              )
            : ListView.builder(
                controller: controller,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detailsScreen(
                                        nftArray[index].imageURl,
                                        nftArray[index].price,
                                        nftArray[index].name)),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      if (nftArray[index].imageURl == null)
                                        Container()
                                      else
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            placeholder: (BuildContext context,
                                                    String url) =>
                                                Container(),
                                            errorWidget: (BuildContext context,
                                                    String url, error) =>
                                                const SizedBox(),
                                            imageUrl: nftArray[index].imageURl,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const Divider(),
                                  Text("${nftArray[index].name}"),
                                  Text(
                                    "\$${nftArray[index].price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // if (index == nftArray.length - 1)
                      //   const Center(
                      //     child: CircularProgressIndicator(
                      //       backgroundColor: Colors.yellow,
                      //     ),
                      //   )
                      // else
                      //   const SizedBox(),
                    ],
                  );
                },
                itemCount: nftArray.length,
              ),
      ),
    );
  }

  Future<void> getURL({
    String? id,
  }) async {
    if (id == null) {
      baseApi =
          'https://api.coingecko.com/api/v3/nfts/list?order=h24_volume_native_asc&per_page=3&page=1';
      getNFTIds(baseApi);
    }
  }

  Future<void> getNFTIds(String url) async {
    final Response res = await _dio.get(url);
    if (res.statusCode == 200) {
      print(res);
      List<dynamic> jsonData = res.data;
      if (jsonData.length == 0) {
        notFound = true;
        setState(() => isLoading = false);
      }

      setState(() {
        idsArray = jsonData.map((json) => NFTModel.fromJson(json)).toList();
        for (var item in idsArray) {
          // Do something with each item
          getNFTDetails(item.id);
        }
      });
    } else {
      setState(() => notFound = true);
    }
  }

  Future<void> getNFTDetails(String id) async {
    final Response res =
        await _dio.get('https://api.coingecko.com/api/v3/nfts/${id}');
    if (res.statusCode == 200) {
      print(res);
      Map<String, dynamic> jsonData = res.data;

      setState(() {
        setState(() {
          NFTModelDetails nftModel = NFTModelDetails.fromJson(jsonData);
          nftArray.add(nftModel);
        });
        // nftArray.add(jsonData.map((json) => NFTModelDetails.fromJson(json));)
      });
    } else {
      setState(() => notFound = true);
    }
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
    getURL();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() => isLoading = true);
      // getNews();
    }
  }
}
