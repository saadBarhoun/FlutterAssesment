import 'package:flutter/material.dart';

class NFTModel {
  String id;

  NFTModel({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  factory NFTModel.fromJson(Map<String, dynamic> json) {
    return NFTModel(
      id: json['id'],
    );
  }
}
