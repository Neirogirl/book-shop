import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../state/app_state.dart';

Future<bool> showAuthDialog(BuildContext context,
    {bool startWithLogin = true}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _AuthDialog(startWithLogin: startWithLogin),
  );
  return result ?? false;
}

class _AuthDialog extends StatefulWidget {
  final bool startWithLogin;
  const _AuthDialog({required this.startWithLogin});

  @override
  State<_AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<_AuthDialog> {
  late bool _isLogin;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLogin = widget.startWithLogin;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_emailController.text.trim().isEmpty) {
      _showSnack('Введите логин');
      return;
    }
        if (_passwordController.text.length < 8) {
      _showSnack('Пароль должен быть минимум 8 символов');
      return;
    }
    if (!_isLogin && _passwordController.text != _confirmController.text) {
      _showSnack('Пароли не совпадают');
      return;
    }
    AppState.instance.login(_emailController.text.trim());
    Navigator.pop(context, true);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isLogin ? 'Вход' : 'Регистрация',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 24),
              const Text('логин',
                  style: TextStyle(fontSize: 13, color: AppTheme.textDark)),
              const SizedBox(height: 6),
              _buildField(_emailController),
              const SizedBox(height: 16),
              const Text('пароль',
                  style: TextStyle(fontSize: 13, color: AppTheme.textDark)),
              const SizedBox(height: 6),
              _buildField(_passwordController, obscure: true),
              if (!_isLogin) ...[
                const SizedBox(height: 16),
                const Text('повторный ввод пароля',
                    style: TextStyle(fontSize: 13, color: AppTheme.textDark)),
                const SizedBox(height: 6),
                _buildField(_confirmController, obscure: true),
              ],
              const SizedBox(height: 24),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    elevation: 0,
                  ),
                  child: Text(_isLogin ? 'Войти' : 'Зарегистрироваться'),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(
                  _isLogin ? 'Регистрация' : 'Вход',
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    decoration: TextDecoration.underline,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.searchBar,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}