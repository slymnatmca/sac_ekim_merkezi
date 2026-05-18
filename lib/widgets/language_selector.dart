import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});
  
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    
    return PopupMenuButton<Locale>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localeProvider.locale.languageCode.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
      onSelected: (locale) {
        localeProvider.setLocale(locale);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: Locale('en'),
          child: Row(
            children: [
              Text('🇬🇧', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: Locale('tr'),
          child: Row(
            children: [
              Text('🇹🇷', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('Türkçe'),
            ],
          ),
        ),
      ],
    );
  }
}
