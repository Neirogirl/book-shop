import '../models/book.dart';

/// Готовый список книг для загрузки в Firestore.
/// Обложки берём с Open Library по ISBN.
class SeedData {
  static List<Book> books = const [
    Book(
      title: 'Мастер и Маргарита',
      author: 'М. Булгаков',
      price: 500,
      description: 'Роман о добре и зле, любви и трусости.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9785040980790-L.jpg',
    ),
    Book(
      title: '1984',
      author: 'Дж. Оруэлл',
      price: 400,
      description: 'Антиутопия о тоталитарном обществе.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780451524935-L.jpg',
    ),
    Book(
      title: 'Преступление и наказание',
      author: 'Ф. Достоевский',
      price: 600,
      description: 'История бывшего студента Раскольникова.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780143058144-L.jpg',
    ),
    Book(
      title: 'Гарри Поттер и философский камень',
      author: 'Дж. Роулинг',
      price: 700,
      description: 'Первая книга о юном волшебнике.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780747532743-L.jpg',
    ),
    Book(
      title: 'Три товарища',
      author: 'Э. М. Ремарк',
      price: 550,
      description: 'Роман о дружбе и любви в послевоенной Германии.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780449912423-L.jpg',
    ),
    Book(
      title: 'Война и мир',
      author: 'Л. Толстой',
      price: 900,
      description: 'Роман-эпопея о войне 1812 года.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9781400079988-L.jpg',
    ),
    Book(
      title: 'Анна Каренина',
      author: 'Л. Толстой',
      price: 650,
      description: 'Роман о любви и трагедии.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780143035008-L.jpg',
    ),
    Book(
      title: 'Атомные привычки',
      author: 'Дж. Клир',
      price: 680,
      description: 'Как приобрести хорошие привычки и избавиться от плохих.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780735211292-L.jpg',
    ),
    Book(
      title: 'Думай медленно… решай быстро',
      author: 'Д. Канеман',
      price: 720,
      description: 'О двух системах мышления.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780374533557-L.jpg',
    ),
    Book(
      title: 'Sapiens. Краткая история человечества',
      author: 'Ю. Харари',
      price: 850,
      description: 'От первых людей до современности.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780062316097-L.jpg',
    ),
    Book(
      title: 'Голодные игры',
      author: 'С. Коллинз',
      price: 600,
      description: 'Антиутопия для подростков.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9780439023481-L.jpg',
    ),
    Book(
      title: 'Наруто. Том 1',
      author: 'М. Кишимото',
      price: 450,
      description: 'Манга о юном ниндзя Наруто.',
      coverUrl: 'https://covers.openlibrary.org/b/isbn/9781569319000-L.jpg',
    ),
  ];
}