import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookService {
  BookService._();
  static final BookService instance = BookService._();

  final CollectionReference<Map<String, dynamic>> _books =
      FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> getBooksStream() {
    return _books.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Book(
          title: (data['title'] as String?) ?? 'Без названия',
          author: (data['author'] as String?) ?? 'Неизвестен',
          price: ((data['price'] as num?) ?? 0).toDouble(),
          description: (data['description'] as String?) ?? '',
          coverUrl: (data['coverUrl'] as String?) ?? '',
        );
      }).toList();
    });
  }

  Future<void> addBook(Book book) async {
    await _books.add({
      'title': book.title,
      'author': book.author,
      'price': book.price,
      'description': book.description,
      'coverUrl': book.coverUrl,
    });
  }
}