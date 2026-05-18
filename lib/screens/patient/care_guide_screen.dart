import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/patient_provider.dart';
import '../../models/patient_model.dart';
import '../../utils/colors.dart';

class CareGuideScreen extends StatelessWidget {
  const CareGuideScreen({super.key});
  
  Color _getWeekColor(int week) {
    if (week <= 2) return AppColors.week1Color;
    if (week <= 4) return AppColors.week4Color;
    if (week <= 8) return AppColors.week8Color;
    if (week <= 12) return AppColors.week12Color;
    return AppColors.week16Color;
  }
  
  IconData _getWeekIcon(int week) {
    if (week <= 2) return Icons.warning_amber_rounded;
    if (week <= 4) return Icons.water_drop;
    if (week <= 8) return Icons.auto_awesome;
    if (week <= 12) return Icons.trending_up;
    return Icons.celebration;
  }
  
  String _getLocalizedString(AppLocalizations l10n, String key) {
    switch (key) {
      case 'week1Title': return l10n.week1Title;
      case 'week1Desc': return l10n.week1Desc;
      case 'week1Tips': return l10n.week1Tips;
      case 'week3Title': return l10n.week3Title;
      case 'week3Desc': return l10n.week3Desc;
      case 'week3Tips': return l10n.week3Tips;
      case 'week5Title': return l10n.week5Title;
      case 'week5Desc': return l10n.week5Desc;
      case 'week5Tips': return l10n.week5Tips;
      case 'week9Title': return l10n.week9Title;
      case 'week9Desc': return l10n.week9Desc;
      case 'week9Tips': return l10n.week9Tips;
      case 'week13Title': return l10n.week13Title;
      case 'week13Desc': return l10n.week13Desc;
      case 'week13Tips': return l10n.week13Tips;
      default: return key;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final patient = authProvider.currentUser as PatientModel;
    final patientProvider = Provider.of<PatientProvider>(context);
    final currentWeek = patient.currentWeek;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.careGuide),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Current Week Card
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.calendar_today, color: Colors.white, size: 48),
                const SizedBox(height: 12),
                Text(
                  '${l10n.currentWeek}: $currentWeek',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${16 - currentWeek} ${l10n.week} remaining',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Week Cards
          ...List.generate(16, (index) {
            final week = index + 1;
            final guide = patientProvider.getCareGuideForWeek(week);
            if (guide == null) return const SizedBox.shrink();
            
            final isCurrentWeek = week == currentWeek;
            final isPastWeek = week < currentWeek;
            final weekColor = _getWeekColor(week);
            
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: isCurrentWeek
                    ? Border.all(color: weekColor, width: 3)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: isCurrentWeek
                        ? weekColor.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: isCurrentWeek ? 20 : 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [weekColor, weekColor.withValues(alpha: 0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_getWeekIcon(week), color: Colors.white, size: 28),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${l10n.week} $week',
                        style: TextStyle(
                          fontWeight: isCurrentWeek ? FontWeight.bold : FontWeight.w600,
                          fontSize: isCurrentWeek ? 18 : 16,
                        ),
                      ),
                      if (isCurrentWeek) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: weekColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      if (isPastWeek) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                      ],
                    ],
                  ),
                  subtitle: Text(
                    _getLocalizedString(l10n, guide.titleKey),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: weekColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getLocalizedString(l10n, guide.descriptionKey),
                              style: const TextStyle(fontSize: 15, height: 1.5),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.tips_and_updates, color: weekColor, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Tips & Care Instructions',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _getLocalizedString(l10n, guide.tipsKey),
                            style: const TextStyle(fontSize: 14, height: 1.8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
