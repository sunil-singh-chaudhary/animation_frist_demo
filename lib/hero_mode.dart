// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class HeroModel {
  String name;
  int age;
  Icon icns;
  HeroModel({
    required this.name,
    required this.age,
    required this.icns,
  });

  HeroModel copyWith({
    String? name,
    int? age,
    Icon? icns,
  }) {
    return HeroModel(
      name: name ?? this.name,
      age: age ?? this.age,
      icns: icns ?? this.icns,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'icns': icns,
    };
  }

  factory HeroModel.fromMap(Map<String, dynamic> map) {
    return HeroModel(
      name: map['name'] as String,
      age: map['age'] as int,
      icns: map['icns'] as Icon,
    );
  }

  String toJson() => json.encode(toMap());

  factory HeroModel.fromJson(String source) =>
      HeroModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Hero(name: $name, age: $age, icns: $icns)';

  @override
  bool operator ==(covariant HeroModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.icns == icns;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ icns.hashCode;
}
