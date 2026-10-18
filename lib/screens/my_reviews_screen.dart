import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../state/app_state.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, showBackButton: true),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Мои отзывы',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark)),
              const SizedBox(height: 16),
              if (AppState.instance.reviews.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.searchBar.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'У вас пока нет отзывов',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                )
              else
                ...AppState.instance.reviews.map((_) => Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.searchBar.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                              color: AppTheme.placeholder,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text('оценка',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textDark)),
                          const SizedBox(height: 6),
                          const Text('сам отзыв книги',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textDark)),
                        ],
                      ),
                    )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}