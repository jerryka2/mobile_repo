import 'package:sprint4_fix/features/home/domain/entity/station.dart';

class StationModel extends Station {
  StationModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}