import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Top section toggles
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsAlerts = false;

  // Notification type toggles
  bool _transactionAlerts = true;
  bool _budgetWarnings = true;
  bool _savingsGoals = false;
  bool _monthlyReports = true;
  bool _billReminders = true;

  // Do not disturb times
  TimeOfDay _fromTime = const TimeOfDay(hour: 22, minute: 0); // 10:00 PM
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 0); // 7:00 AM

  Future<void> _pickTime({required bool isFrom}) async {
    final initial = isFrom ? _fromTime : _toTime;
    final picked =
        await showTimePicker(context: context, initialTime: initial);
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromTime = picked;
        } else {
          _toTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      time,
      alwaysUse24HourFormat: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFF5F5F7);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationGroupCard(
                children: [
                  _NotificationSwitchRow(
                    title: 'Push Notifications',
                    subtitle: 'Receive alerts on your device',
                    value: _pushNotifications,
                    onChanged: (v) =>
                        setState(() => _pushNotifications = v),
                  ),
                  const Divider(height: 1),
                  _NotificationSwitchRow(
                    title: 'Email Notifications',
                    subtitle: 'Receive updates via email',
                    value: _emailNotifications,
                    onChanged: (v) =>
                        setState(() => _emailNotifications = v),
                  ),
                  const Divider(height: 1),
                  _NotificationSwitchRow(
                    title: 'SMS Alerts',
                    subtitle: 'Get text message notifications',
                    value: _smsAlerts,
                    onChanged: (v) =>
                        setState(() => _smsAlerts = v),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Notification Types',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              _NotificationTypeCard(
                title: 'Transaction Alerts',
                subtitle: 'When transaction is added',
                value: _transactionAlerts,
                onChanged: (v) =>
                    setState(() => _transactionAlerts = v),
              ),
              const SizedBox(height: 10),
              _NotificationTypeCard(
                title: 'Budget Warnings',
                subtitle: 'When approaching budget limits',
                value: _budgetWarnings,
                onChanged: (v) =>
                    setState(() => _budgetWarnings = v),
              ),
              const SizedBox(height: 10),
              _NotificationTypeCard(
                title: 'Savings Goals',
                subtitle: 'Updates on your savings progress',
                value: _savingsGoals,
                onChanged: (v) =>
                    setState(() => _savingsGoals = v),
              ),
              const SizedBox(height: 10),
              _NotificationTypeCard(
                title: 'Monthly Reports',
                subtitle: 'Receive financial summaries',
                value: _monthlyReports,
                onChanged: (v) =>
                    setState(() => _monthlyReports = v),
              ),
              const SizedBox(height: 10),
              _NotificationTypeCard(
                title: 'Bill Reminders',
                subtitle: 'Never miss a payment deadline',
                value: _billReminders,
                onChanged: (v) =>
                    setState(() => _billReminders = v),
              ),
              const SizedBox(height: 28),
              const Text(
                'Do Not Disturb',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Silence notifications during specific hours',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'From',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _TimePill(
                    value: _formatTime(_fromTime),
                    onTap: () => _pickTime(isFrom: true),
                  ),

                  const SizedBox(width: 32),

                  const Text(
                    'To',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _TimePill(
                    value: _formatTime(_toTime),
                    onTap: () => _pickTime(isFrom: false),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationGroupCard extends StatelessWidget {
  final List<Widget> children;

  const _NotificationGroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _NotificationSwitchRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationSwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          _CustomSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _NotificationTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationTypeCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          _CustomSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _TimePill extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const _TimePill({
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,       // matches Figma: long pill
        height: 44,       // Figma input height
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // NOT fully circular
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: Colors.black,
      inactiveTrackColor: const Color(0xFFE5E5EA),
      activeColor: Colors.white,
      inactiveThumbColor: Colors.white,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}