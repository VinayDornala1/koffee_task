class ImageUploadData {
  final int id;
  final String path;

  ImageUploadData({required this.id, required this.path});

  factory ImageUploadData.fromJson(Map<String, dynamic> json) {
    return ImageUploadData(
      id: json['id'],
      path: json['path'],
    );
  }
}

class ImageUploadResponse {
  final int statusCode;
  final String status;
  final bool success;
  final String message;
  final List<ImageUploadData> data;

  ImageUploadResponse({
    required this.statusCode,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponse(
      statusCode: json['status_code'],
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => ImageUploadData.fromJson(e))
          .toList(),
    );
  }
}
