import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../state/app_state.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _city;
  late final TextEditingController _address;

  @override
  void initState() {
    super.initState();
    final s = AppState.instance;
    _phone = TextEditingController(
        text: s.userPhone == 'не указан' ? '' : s.userPhone);
    _email = TextEditingController(text: s.userEmail ?? '');
    _city = TextEditingController(
        text: s.userCity == 'не указан' ? '' : s.userCity);
    _address = TextEditingController(
        text: s.userAddress == 'не указан' ? '' : s.userAddress);
  }

  @override
  void dispose() {
    _phone.dispose();
    _email.dispose();
    _city.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, showBackButton: true),
      endDrawer: buildCommonDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Изменение профиля',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 24),
              // Аватар
              Center(
                child: Column(
                  children: [
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
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: const Text('изменить фото',
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.textDark)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _label('номер телефона'),
              _field(_phone),
              const SizedBox(height: 12),
              _label('email'),
              _field(_email),
              const SizedBox(height: 12),
              _label('город'),
              _field(_city),
              const SizedBox(height: 12),
              _label('Адрес почтового отделения'),
              _field(_address),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 160,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      AppState.instance.updateProfile(
                        phone: _phone.text.trim().isEmpty
                            ? null
                            : _phone.text.trim(),
                        email: _email.text.trim(),
                        city: _city.text.trim().isEmpty
                            ? null
                            : _city.text.trim(),
                        address: _address.text.trim().isEmpty
                            ? null
                            : _address.text.trim(),
                      );
                      AppState.instance.openProfile(ProfilePage.main);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('сохранить'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text,
            style: const TextStyle(
                fontSize: 13, color: AppTheme.textDark)),
      );

  Widget _field(TextEditingController c) => TextField(
        controller: c,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.searchBar,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      );
}