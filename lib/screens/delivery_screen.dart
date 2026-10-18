import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../state/app_state.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

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
              const Text('Доставка',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark)),
              const SizedBox(height: 16),
                            const Text('Заказы в пути',
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.textDark)),
              const SizedBox(height: 12),
              if (AppState.instance.orders.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.searchBar.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Заказов в пути нет',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                )
              else
                ...AppState.instance.orders.map((_) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _orderCard(),
                    )),
              const SizedBox(height: 24),
              const Text('Данные доставки',
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.textDark)),
              const SizedBox(height: 8),
              const Text('город',
                  style: TextStyle(fontSize: 13, color: Colors.black45)),
              Text(AppState.instance.userCity!,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark)),
              const SizedBox(height: 8),
              const Text('адрес почтового отделения',
                  style: TextStyle(fontSize: 13, color: Colors.black45)),
              Text(AppState.instance.userAddress!,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.searchBar.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.placeholder,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('информация',
                    style: TextStyle(
                        fontSize: 13, color: AppTheme.textDark)),
                SizedBox(height: 4),
                Text('статус доставки',
                    style: TextStyle(
                        fontSize: 13, color: AppTheme.textDark)),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('ожидается',
                      style: TextStyle(
                          fontSize: 12, color: Colors.black54)),
                ),
                SizedBox(height: 2),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('число',
                      style: TextStyle(
                          fontSize: 12, color: Colors.black54)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}