import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/auth_dialogs.dart';
import '../state/app_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
            final items = AppState.instance.cartItems;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Корзина',
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

                // === Не вошли в аккаунт ===
                if (!isLoggedIn)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.shopping_cart_outlined,
                                size: 80, color: Colors.black26),
                            const SizedBox(height: 16),
                            const Text(
                              'Войдите в аккаунт,\nчтобы пользоваться корзиной',
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

                // === Вошли, но корзина пуста ===
                else if (items.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Корзина пуста',
                        style:
                            TextStyle(fontSize: 16, color: Colors.black45),
                      ),
                    ),
                  )

                // === Вошли, есть товары ===
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final book = items[index];
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            border: Border.all(
                                color: AppTheme.primary, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  color: AppTheme.placeholder,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.book,
                                    size: 32, color: Colors.black26),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      book.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppTheme.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      book.author,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${book.price.toStringAsFixed(0)} ₽',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.black45, size: 20),
                                onPressed: () =>
                                    AppState.instance.removeFromCart(book),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                // Нижняя панель — только если вошли и есть товары
                if (isLoggedIn && items.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Заказ оформлен! Спасибо!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            AppState.instance.clearCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                          ),
                          child: const Text('Оформить заказ'),
                        ),
                        const Spacer(),
                        Text(
                          'Цена: ${AppState.instance.cartTotal.toStringAsFixed(0)} ₽',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark),
                        ),
                      ],
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