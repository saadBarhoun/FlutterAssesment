import 'package:flutter/material.dart';

class NFTModelDetails {
  double price;
  String name;
  String imageURl;

  NFTModelDetails(
      {required this.price, required this.name, required this.imageURl});

  Map<String, dynamic> toJson() {
    return {'price': price, 'name': name, 'image': imageURl};
  }

  factory NFTModelDetails.fromJson(Map<String, dynamic> json) {
    return NFTModelDetails(
        price: json['floor_price']['usd'],
        name: json['name'],
        imageURl: json['image']['small']);
  }
}
