import 'package:flutter/material.dart';
import '../models/book.dart';

enum InfoPage { about, publishers, news, reviews, chat, loyalty }
enum ProfilePage { main, edit, delivery, reviews, orderDetails }

class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  // === АВТОРИЗАЦИЯ ===
  bool _isLoggedIn = false;
  String? _userEmail;
  String? _userPhone;
  String? _userCity;
  String? _userAddress;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  String? get userPhone => _userPhone ?? 'не указан';
  String? get userCity => _userCity ?? 'не указан';
  String? get userAddress => _userAddress ?? 'не указан';

  void login(String email) {
    _userEmail = email;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _userEmail = null;
    _userPhone = null;
    _userCity = null;
    _userAddress = null;
    _isLoggedIn = false;
    _cartItems.clear();
    _favorites.clear();
    _openedProfile = null;
    notifyListeners();
  }

  void updateProfile({
    String? phone,
    String? email,
    String? city,
    String? address,
  }) {
    if (phone != null) _userPhone = phone;
    if (email != null && email.isNotEmpty) _userEmail = email;
    if (city != null) _userCity = city;
    if (address != null) _userAddress = address;
    notifyListeners();
  }

  // === ОТКРЫТАЯ КНИГА ===
  Book? _openedBook;
  Book? get openedBook => _openedBook;

  void openBook(Book b) {
    _openedBook = b;
    _openedInfoPage = null;
    _openedCategory = null;
    _openedProfile = null;
    notifyListeners();
  }

  void closeBook() {
    _openedBook = null;
    notifyListeners();
  }

    // === ОТКРЫТАЯ ИНФО-СТРАНИЦА ===
  InfoPage? _openedInfoPage;
  bool _infoPageFromProfile = false;
  InfoPage? get openedInfoPage => _openedInfoPage;

  void openInfoPage(InfoPage p, {bool fromProfile = false}) {
    _openedInfoPage = p;
    _infoPageFromProfile = fromProfile;
    _openedBook = null;
    _openedCategory = null;
    _openedProfile = null;
    notifyListeners();
  }

  void closeInfoPage() {
    final wasFromProfile = _infoPageFromProfile;
    _openedInfoPage = null;
    _infoPageFromProfile = false;
    // Если пришли из профиля — вернёмся в главный профиль
    if (wasFromProfile) {
      _openedProfile = ProfilePage.main;
    }
    notifyListeners();
  }
  // === ОТКРЫТАЯ КАТЕГОРИЯ ===
  String? _openedCategory;
  String? get openedCategory => _openedCategory;

  void openCategory(String c) {
    _openedCategory = c;
    _openedBook = null;
    _openedInfoPage = null;
    _openedProfile = null;
    notifyListeners();
  }

  void closeCategory() {
    _openedCategory = null;
    notifyListeners();
  }

  // === ОТКРЫТАЯ СТРАНИЦА ПРОФИЛЯ ===
  ProfilePage? _openedProfile;
  ProfilePage? get openedProfile => _openedProfile;

  void openProfile(ProfilePage p) {
    _openedProfile = p;
    _openedBook = null;
    _openedInfoPage = null;
    _openedCategory = null;
    notifyListeners();
  }

  void closeProfile() {
    _openedProfile = null;
    notifyListeners();
  }

  // === КОРЗИНА ===
  final List<Book> _cartItems = [];

  List<Book> get cartItems => List.unmodifiable(_cartItems);
  int get cartCount => _cartItems.length;
  double get cartTotal => _cartItems.fold(0, (s, b) => s + b.price);

  void addToCart(Book book) {
    _cartItems.add(book);
    notifyListeners();
  }

  void removeFromCart(Book book) {
    _cartItems.remove(book);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // === ИЗБРАННОЕ ===
  final List<Book> _favorites = [];

  List<Book> get favorites => List.unmodifiable(_favorites);
  int get favoritesCount => _favorites.length;

  bool isFavorite(Book book) {
    return _favorites.any(
        (x) => x.title == book.title && x.author == book.author);
  }

  void toggleFavorite(Book book) {
    final exists = isFavorite(book);
    if (exists) {
      _favorites.removeWhere(
          (x) => x.title == book.title && x.author == book.author);
    } else {
      _favorites.add(book);
    }
    notifyListeners();
  }
    // === ЗАКАЗЫ И ОТЗЫВЫ (пока пустые, для пустых экранов) ===
  final List<Map<String, dynamic>> _orders = [];
  final List<Map<String, dynamic>> _reviews = [];

  List<Map<String, dynamic>> get orders => List.unmodifiable(_orders);
  List<Map<String, dynamic>> get reviews => List.unmodifiable(_reviews);
}