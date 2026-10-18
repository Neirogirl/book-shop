import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'catalog_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'book_detail_screen.dart';
import 'info_screen.dart';
import 'category_screen.dart';
import 'profile_screen.dart';
import 'profile_edit_screen.dart';
import 'delivery_screen.dart';
import 'my_reviews_screen.dart';
import 'order_details_screen.dart';
import '../state/app_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CatalogScreen(),
    FavoritesScreen(),
    CartScreen(),
  ];

  void _onTabTapped(int index) {
    AppState.instance.closeBook();
    AppState.instance.closeInfoPage();
    AppState.instance.closeCategory();
    AppState.instance.closeProfile();
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: AppState.instance,
        builder: (context, _) {
          final state = AppState.instance;

          if (state.openedBook != null) {
            return BookDetailScreen(book: state.openedBook!);
          }
          if (state.openedInfoPage != null) {
            return InfoScreen(page: state.openedInfoPage!);
          }
          if (state.openedCategory != null) {
            return CategoryScreen(category: state.openedCategory!);
          }

          // === Страницы профиля ===
          final profile = state.openedProfile;
          if (profile != null) {
            switch (profile) {
              case ProfilePage.main:
                return const ProfileScreen();
              case ProfilePage.edit:
                return const ProfileEditScreen();
              case ProfilePage.delivery:
                return const DeliveryScreen();
              case ProfilePage.reviews:
                return const MyReviewsScreen();
              case ProfilePage.orderDetails:
                return const OrderDetailsScreen();
            }
          }

          return _pages[_selectedIndex];
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: AppState.instance,
        builder: (context, _) {
          final cartCount = AppState.instance.cartCount;
          return BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Главная',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                label: 'Каталог',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Избранное',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    if (cartCount > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Корзина',
              ),
            ],
          );
        },
      ),
    );
  }
}