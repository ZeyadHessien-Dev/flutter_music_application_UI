class SongsModel {
  final String title;
  final String description;
  final String coverUrl;
  final String url;

  SongsModel({
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.url,
  });

 static List<SongsModel> songs = [
    SongsModel(
      title: "Glass",
      description: "Glass",
      coverUrl: "assets/images/glass.jpg",
      url: "assets/music/glass.mp3",
    ),
    SongsModel(
      title: "Illusions",
      description: "Illusions",
      coverUrl: "assets/images/illusions.jpg",
      url: "assets/music/illusions.mp3",
    ),
    SongsModel(
      title: "Pray",
      description: "Pray",
      coverUrl: "assets/images/pray.jpg",
      url: "assets/music/pray.mp3",
    ),
  ];
}
