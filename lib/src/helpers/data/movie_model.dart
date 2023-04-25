class MovieModel {
  String bgImage;
  String name;
  String genre;
  String about;
  int? date;
  String rating;

  MovieModel({
    required this.bgImage,
    this.date = 2024,
    required this.name,
    required this.genre,
    required this.about,
    required this.rating,
  });
}