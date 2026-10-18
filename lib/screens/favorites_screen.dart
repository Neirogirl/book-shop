import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/auth_dialogs.dart';
import '../state/app_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: AppState.instance,
          builder: (context, _) {
            final isLoggedIn = AppState.instance.isLoggedIn;
            final favorites = AppState.instance.favorites;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Избранное',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                buildSearchBar(),
                const SizedBox(height: 16),

                // === Не вошли ===
                if (!isLoggedIn)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.favorite_border,
                                size: 80, color: Colors.black26),
                            const SizedBox(height: 16),
                            const Text(
                              'Войдите в аккаунт,\nчтобы сохранять книги в избранное',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 46,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => showAuthDialog(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text('Войти'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )

                // === Вошли, но избранное пусто ===
                else if (favorites.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'В избранном пока пусто',
                        style:
                            TextStyle(fontSize: 16, color: Colors.black45),
                      ),
                    ),
                  )

                // === Вошли, есть избранные книги ===
                else
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final book = favorites[index];
                        return GestureDetector(
                          onTap: () => AppState.instance.openBook(book),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppTheme.placeholder,
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.book,
                                          size: 40, color: Colors.black26),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: GestureDetector(
                                        onTap: () =>
                                            AppState.instance.toggleFavorite(book),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.close,
                                              size: 16,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              Text(
                                '${book.price.toStringAsFixed(0)} ₽',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}