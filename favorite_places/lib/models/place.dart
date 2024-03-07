// ignore_for_file: public_member_api_docs, sort_constructors_first

//Modelo de Place
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File? image;
  final String description;
  final double latitude;
  final double longitude;

  Place({
    required this.title,
    required this.image,
    required this.description,
    required this.latitude,
    required this.longitude,
  }) : id = uuid.v4();

  Place copyWith({
    String? id,
    String? title,
    File? image,
    String? description,
    double? latitude,
    double? longitude,
  }) {
    return Place(
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
