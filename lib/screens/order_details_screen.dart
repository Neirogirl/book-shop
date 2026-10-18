import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
              const Text('Сведения о заказе',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark)),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.placeholder,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 20),
              const Text('название товара',
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.textDark)),
              const SizedBox(height: 8),
              const Text('цена',
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.textDark)),
              const SizedBox(height: 8),
              const Text('номер карты (с которой\nсовершалась покупка)',
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.textDark)),
              const SizedBox(height: 8),
              const Text('время покупки',
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.textDark)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}