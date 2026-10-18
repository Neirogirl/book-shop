import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../state/app_state.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Художественная литература',
      'Young Adult',
      'Учебная литература',
      'Саморазвитие',
      'Психология',
      'Книги для детей',
      'Книги для подростков',
      'Книги для родителей',
      'Комиксы и манга',
      'Книги на иностранных языках',
      'Хобби и досуг',
      'Здоровье и спорт',
      'Научно-популярные книги',
    ];

    return Scaffold(
      appBar: buildCommonAppBar(context),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Каталог',
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length,
                itemBuilder: (context, index) => _buildCategoryButton(
                  categories[index],
                  () => AppState.instance.openCategory(categories[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.background,
            border: Border.all(color: AppTheme.primary, width: 1.2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, color: AppTheme.textDark),
          ),
        ),
      ),
    );
  }
}