import 'package:flutter/material.dart';
import 'package:news_app/core/services/notification_service.dart';
import 'package:news_app/widgets/profile/notification_row.dart';
import 'package:news_app/widgets/profile/notification_skeleton.dart';
import 'package:news_app/widgets/profile/section_card.dart';
import 'package:news_app/widgets/profile/setting_section.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({super.key});

  @override
  State<NotificationSection> createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  bool _dailyDigest = true;
  bool _breakingNew = true;
  bool _seriesAlerts = false;
  bool _isLoading = true;

  final _service = NotificationService.instance;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final daily = await _service.getDailyDigest();
    final breaking = await _service.getBreakingNews();
    final series = await _service.getSeriseAlerts();

    if (!mounted) return;
    setState(() {
      _breakingNew = breaking;
      _dailyDigest = daily;
      _seriesAlerts = series;
      _isLoading = false;
    });
  }

  Future<void> _toggleDailyDigest(bool value) async {
    setState(() => _dailyDigest = value);
    await _service.setDailyDigest(value);
  }

  Future<void> _toggleBreakingNews(bool value) async {
    setState(() => _breakingNew = value);
    await _service.setBreakingNews(value);
  }

  Future<void> _toggleSeriseAlerts(bool value) async {
    setState(() => _seriesAlerts = value);
    await _service.setSeriesAlerts(value);
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Notification Preferences',
      icon: Icons.notifications_outlined,
      children: [
        if (_isLoading)
          const NotificationSkeleton()
        else ...[
          NotificationRow(
            title: 'Daily Digest',
            description: 'A moring summry of the world\'s top stories.',
            value: _dailyDigest,
            onChanged: _toggleDailyDigest,
          ),

          const SettingsDivider(),

          NotificationRow(
            title: 'Breaking News',
            description: 'Instant alerts for major global events.',
            value: _breakingNew,
            onChanged: _toggleBreakingNews,
          ),

          const SettingsDivider(),

          NotificationRow(
            title: 'Series Alerts',
            description: 'When new chapters in your followed series drop.',
            value: _seriesAlerts,
            onChanged: _toggleSeriseAlerts,
          ),
        ],
      ],
    );
  }
}
