import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koffeekodes_task/models/image_upload_response.dart';
import '../models/user_model.dart';
import 'dart:io';
class UserRepository {
  final String baseUrl = 'http://64.227.136.129/api/v1/admin';
  final String authToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IlJhamFuaSIsInNlY3JldCI6InRlc3QiLCJwYXNzd29yZCI6IlJhamFuaUAwMTEyIiwicm9sZSI6IkVtcGxveWVlIiwiaWQiOjM1LCJ1c2VyVHlwZSI6ImFkbWluIiwicm9sZUlkIjo0LCJ1c2VyX2FjY2VzcyI6InVzZXIiLCJjb21wYW55IjoiS29mZmVlS29kZXMgSW5ub3ZhdGlvbnMgUFZUIExURCIsImlhdCI6MTc1ODE3NDgxMCwiZXhwIjoxNzYwNzY2ODEwLCJhdWQiOiJhZG1pbiIsImlzcyI6ImFkbWluIiwic3ViIjoiYWRtaW4ifQ.7x0ePgJ8r95hNm-2v9nm2AtzV6h5ubZOwLt7phpT_Mw'; // Replace with your actual key

  Future<UserListResponse> fetchUsers({int limit = 10, int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/list?limit=$limit&page=$page'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return UserListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<ImageUploadResponse> uploadImage(String imagePath) async {
    var uri = Uri.parse('$baseUrl/image-upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('path', imagePath))
      ..headers.addAll({
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'multipart/form-data',
      });

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return ImageUploadResponse.fromJson(
        Map<String, dynamic>.from(jsonDecode(response.body)),
      );
    } else {
      throw Exception('Failed to upload image');
    }
  }
  Future<void> createUser(Map<String, dynamic> userData) async {
    final uri = Uri.parse('$baseUrl/user');

    // 👇 Print the raw userData map
    print("User Data (raw Map): $userData");

    // 👇 Convert to JSON and print
    final jsonBody = jsonEncode(userData);
    print("User Data (JSON Body): $jsonBody");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create user: ${response.body}');
    } else {
      print('Success 🎉');
    }
  }
Future<http.Response> deleteUser(int userId) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/user/$userId'),
    headers: {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to delete user');
  }else {
    print('User deleted successfully');
    return response;

  }
}}