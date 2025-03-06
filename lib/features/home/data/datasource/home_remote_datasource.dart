import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint4_fix/app/constants/api_endpoint.dart';
import 'package:sprint4_fix/features/home/data/model/station_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchStations();
  Future<Map<String, dynamic>> fetchProfile();
  Future<StationModel?> getStation(String stationId); // New method
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchStations() async {
    final String baseUrl =
        Platform.isIOS ? ApiEndpoints.iosBaseUrl : ApiEndpoints.baseUrl;
    final url = Uri.parse('$baseUrl${ApiEndpoints.station}');

    print("Fetching from API: $url");

    try {
      final response = await http.get(url);
      print("Raw API Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print("Decoded Data: $data");

        if (data.containsKey('success') && data['success'] == true) {
          if (data.containsKey('stations') && data['stations'] is List) {
            return List<Map<String, dynamic>>.from(data['stations']);
          } else {
            throw Exception(
                "Unexpected 'stations' format: ${data['stations']}");
          }
        } else {
          throw Exception("API error: ${data['message']}");
        }
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching stations: $e");
      throw Exception("Error fetching stations: $e");
    }
  }

  @override
  Future<Map<String, dynamic>> fetchProfile() async {
    final String baseUrl =
        Platform.isIOS ? ApiEndpoints.iosBaseUrl : ApiEndpoints.baseUrl;
    final url = Uri.parse('$baseUrl${ApiEndpoints.profile}');

    print("Fetching profile from API: $url");

    final String? token = await _getToken();
    if (token == null) {
      throw Exception("No authentication token available");
    }

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print("Raw API Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print("Decoded Profile Data: $data");

        if (data.containsKey('success') && data['success'] == true) {
          if (data.containsKey('user') && data['user'] is Map) {
            return Map<String, dynamic>.from(data['user']);
          } else {
            throw Exception("Unexpected 'user' format: ${data['user']}");
          }
        } else {
          throw Exception("API error: ${data['message']}");
        }
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
      throw Exception("Error fetching profile: $e");
    }
  }

  @override
  Future<StationModel?> getStation(String stationId) async {
    final String baseUrl =
        Platform.isIOS ? ApiEndpoints.iosBaseUrl : ApiEndpoints.baseUrl;
    final url = Uri.parse(
        '$baseUrl${ApiEndpoints.station}/$stationId'); // Assumes /stations/{id}

    print("Fetching station from API: $url");

    final String? token = await _getToken();
    if (token == null) {
      throw Exception("No authentication token available");
    }

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      print("Raw API Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print("Decoded Station Data: $data");

        if (data.containsKey('success') && data['success'] == true) {
          if (data.containsKey('station') && data['station'] is Map) {
            return StationModel.fromJson(data['station']);
          } else {
            throw Exception("Unexpected 'station' format: ${data['station']}");
          }
        } else {
          throw Exception("API error: ${data['message']}");
        }
      } else if (response.statusCode == 404) {
        return null; // Station not found
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching station: $e");
      throw Exception("Error fetching station: $e");
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
