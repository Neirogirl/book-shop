class Book {
  final String title;
  final String author;
  final double price;
  final String description;
  final String coverUrl;

  const Book({
    required this.title,
    required this.author,
    required this.price,
    required this.description,
    this.coverUrl = '',
  });
}