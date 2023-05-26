import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class detailsScreen extends StatelessWidget {
  String imgUrl;
  double price;
  String title;
  detailsScreen(this.imgUrl, this.price, this.title);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'NFT Details',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  //navigation
                  Navigator.pop(context);
                },
                icon: Icon(Icons.back_hand))
          ],
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                placeholder: (BuildContext context, String url) => Container(),
                errorWidget: (BuildContext context, String url, error) =>
                    const SizedBox(),
                imageUrl: imgUrl,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '${price}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
