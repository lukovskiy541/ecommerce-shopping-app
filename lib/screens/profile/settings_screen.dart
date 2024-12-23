import 'package:app_settings/app_settings.dart';
import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, bottom: 30),
            child: Text('Налаштування',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Хочу отримувати повідомлення'),
            subtitle: Text(
                'Увімкніть повідомлення щоб бути в курсі трендів, спеціальних пропозицій'),
            onTap: () {
              AppSettings.openAppSettings(type: AppSettingsType.notification);
            },
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('Видалення акаунту'),
            subtitle: Text(
                'Ваші персональні дані, історія покупок будуть видалені без можливості відновлення'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Видалити акаунт?'),
                  content: Text(
                    'Це дію неможливо буде скасувати. Ви впевнені, що хочете видалити акаунт?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Скасувати'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Видалити'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                context.read<AuthBloc>().add(DeleteAccountRequestedEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Акаунт видалено успішно')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
