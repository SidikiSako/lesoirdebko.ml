class Article {
  final int id;
  final String date;
  final String title;
  final String content;
  final String author;
  final String imageUrl;
  final String excerpt;

  Article({
    this.author,
    this.content,
    this.date,
    this.id,
    this.imageUrl,
    this.title,
    this.excerpt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      date: json['modified_gmt'],
      content: json['content']['rendered'],
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      author: json['_embedded']['author'][0]['name'],
      imageUrl: json['_embedded']['wp:featuredmedia'][0]['link'],
    );
  }
}
