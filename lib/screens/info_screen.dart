import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../state/app_state.dart';

class InfoScreen extends StatelessWidget {
  final InfoPage page;
  const InfoScreen({super.key, required this.page});

    String get _title {
    if (page == InfoPage.about) return 'О нас';
    if (page == InfoPage.publishers) return 'Наши издательства';
    if (page == InfoPage.news) return 'Новости';
    if (page == InfoPage.reviews) return 'Отзывы';
    if (page == InfoPage.chat) return 'Служба поддержки'; // было "Чат с консультантом"
    return 'Программа лояльности';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, showBackButton: true),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (page == InfoPage.about ||
        page == InfoPage.publishers ||
        page == InfoPage.news ||
        page == InfoPage.reviews) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.placeholder,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    if (page == InfoPage.chat) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.placeholder,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Text('Чат',
                    style: TextStyle(color: Colors.black38)),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.searchBar,
                borderRadius: BorderRadius.circular(21),
              ),
              alignment: Alignment.centerLeft,
              child: const Text('написать',
                  style: TextStyle(color: Colors.black54, fontSize: 13)),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.searchBar,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('количество ваших\nбонусов',
                    style: TextStyle(
                        fontSize: 14, color: AppTheme.textDark)),
                SizedBox(height: 8),
                Text('число',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Информация',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark)),
          const SizedBox(height: 8),
          const Text(
            'бонусы начисляются....',
            style: TextStyle(fontSize: 14, color: AppTheme.textDark),
          ),
        ],
      ),
    );
  }
}