class ImageModel {
  final int id;
  final String path;

  ImageModel({required this.id, required this.path});

  // Factory constructor to create an ImageModel from a Map
  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      path: map['path'],
    );
  }

  // Method to convert ImageModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
    };
  }
}
