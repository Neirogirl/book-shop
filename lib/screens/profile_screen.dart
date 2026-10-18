import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../state/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return Scaffold(
      appBar: buildCommonAppBar(context, showBackButton: false),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Профиль',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 20),

              // === Верхняя часть: аватар + данные ===
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Аватар
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      color: AppTheme.placeholder,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person,
                        size: 60, color: Colors.black26),
                  ),
                  const SizedBox(width: 16),
                  // Данные
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _row('почта', state.userEmail ?? '—'),
                        const SizedBox(height: 8),
                        _row('номер телефона', state.userPhone!),
                        const SizedBox(height: 8),
                        _row('город', state.userCity!),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => AppState.instance
                              .openProfile(ProfilePage.edit),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppTheme.primary, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'изменить данные',
                              style: TextStyle(
                                  fontSize: 12, color: AppTheme.textDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // === Заказы ===
                            const Text(
                'Заказы',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),
              if (state.orders.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.searchBar.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'У вас пока нет заказов',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => AppState.instance
                          .openProfile(ProfilePage.orderDetails),
                      child: Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.placeholder,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 28),

              // === Пункты меню ===
              _menuItem('Доставка', ProfilePage.delivery),
              _menuItem('Программа лояльности', InfoPage.loyalty),
              _menuItem('Мои отзывы', ProfilePage.reviews),
              const SizedBox(height: 28),

              // === Выход ===
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton(
                  onPressed: () {
                    AppState.instance.logout();
                    AppState.instance.closeProfile();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  child: const Text('Выйти из аккаунта'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13, color: Colors.black54)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark),
          ),
        ),
      ],
    );
  }

    Widget _menuItem(String title, dynamic page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (page is ProfilePage) {
            AppState.instance.openProfile(page);
          } else if (page is InfoPage) {
            // Пришли из профиля → при возврате вернёмся в профиль
            AppState.instance.openInfoPage(page, fromProfile: true);
          }
        },
        child: Row(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 15, color: AppTheme.textDark)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}