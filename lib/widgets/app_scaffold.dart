import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';
import 'auth_dialogs.dart';

AppBar buildCommonAppBar(BuildContext context, {bool showBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final state = AppState.instance;
              // Если открыт профиль — ведём на главную профиля, а не закрываем всё
              if (state.openedProfile != null) {
                if (state.openedProfile == ProfilePage.main) {
                  state.closeProfile();
                } else {
                  state.openProfile(ProfilePage.main);
                }
                return;
              }
              // Обычное поведение — закрываем книгу/инфо/категорию
              state.closeBook();
              state.closeInfoPage();
              state.closeCategory();
            },
          )
        : null,
    title: Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
        children: const [
          TextSpan(
            text: 'Книго',
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: 'Мир',
            style: TextStyle(color: Color(0xFFD4E29B)),
          ),
        ],
      ),
    ),
    actions: [
      AnimatedBuilder(
        animation: AppState.instance,
        builder: (context, _) {
          if (AppState.instance.isLoggedIn) {
            return IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () =>
                  AppState.instance.openProfile(ProfilePage.main),
            );
          }
          return TextButton(
            onPressed: () => showAuthDialog(context),
            child: const Text('войти',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          );
        },
      ),
      Builder(
        builder: (innerContext) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(innerContext).openEndDrawer(),
        ),
      ),
    ],
  );
}

/// Элемент бокового меню. Если page == null — это заголовок (не кликабельный).
class _DrawerEntry {
  final String title;
  final InfoPage? page;
  const _DrawerEntry(this.title, [this.page]);
}

Widget buildCommonDrawer(BuildContext context) {
  const entries = [
    _DrawerEntry('О нас'),
    _DrawerEntry('Наши издательства', InfoPage.publishers),
    _DrawerEntry('Новости', InfoPage.news),
    _DrawerEntry('Отзывы', InfoPage.reviews),
    _DrawerEntry('Служба поддержки'),
    _DrawerEntry('Чат с консультантом', InfoPage.chat),
    _DrawerEntry('Программа лояльности', InfoPage.loyalty),
  ];

  return Drawer(
    backgroundColor: AppTheme.background,
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.menu, color: AppTheme.textDark),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 12),
          ...entries.map((e) {
            // Заголовок — жирный, не кликабельный
            if (e.page == null) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 6),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    e.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
              );
            }
            // Обычный кликабельный пункт
            return InkWell(
              onTap: () {
                Navigator.pop(context);
                AppState.instance.openInfoPage(e.page!);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    e.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}

Widget buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppTheme.searchBar,
        borderRadius: BorderRadius.circular(21),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.black54, size: 20),
          SizedBox(width: 8),
          Text('поиск книг, авторов…',
              style: TextStyle(color: Colors.black54, fontSize: 13)),
        ],
      ),
    ),
  );
}