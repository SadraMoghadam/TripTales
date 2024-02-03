class TaleModel {
  final String? id;
  final String name;
  final String imagePath;
  final String canvas;
  final bool liked;
  final List<String>? cardsFK;

  TaleModel({
    this.id,
    required this.name,
    required this.imagePath,
    required this.canvas,
    this.liked = false,
    this.cardsFK,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'canvas': canvas,
      'liked': liked,
      'cardsFK': cardsFK,
    };
  }
}
