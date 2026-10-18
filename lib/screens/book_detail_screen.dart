import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../models/book.dart';
import '../widgets/auth_dialogs.dart';
import '../state/app_state.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, showBackButton: true),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.placeholder,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: book.coverUrl.isNotEmpty
                          ? Image.network(
                              book.coverUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.primary,
                                  ),
                                );
                              },
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(Icons.book,
                                    size: 80, color: Colors.black26),
                              ),
                            )
                          : const Center(
                              child: Icon(Icons.book,
                                  size: 80, color: Colors.black26),
                            ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${book.price.toStringAsFixed(0)} ₽',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('описание',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    Text(
                      book.description,
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textDark,
                          height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    const Text('характеристики',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    Text(
                        'Автор: ${book.author}\nИздательство: —\nГод: —\nСтраниц: —',
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textDark,
                            height: 1.5)),
                    const SizedBox(height: 20),
                    const Text('Отзывы',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    const Text('Пока отзывов нет',
                        style: TextStyle(
                            fontSize: 14, color: Colors.black45)),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!AppState.instance.isLoggedIn) {
                            final ok = await showAuthDialog(context);
                            if (!ok) return;
                          }
                          AppState.instance.addToCart(book);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '«${book.title}» добавлена в корзину'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text('добавить в корзину',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedBuilder(
                    animation: AppState.instance,
                    builder: (context, _) {
                      final isFav = AppState.instance.isFavorite(book);
                      return IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : AppTheme.textDark,
                          size: 28,
                        ),
                        onPressed: () async {
                          if (!AppState.instance.isLoggedIn) {
                            final ok = await showAuthDialog(context);
                            if (!ok) return;
                          }
                          AppState.instance.toggleFavorite(book);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}