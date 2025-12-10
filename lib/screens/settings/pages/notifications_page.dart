import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // General notifications
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsAlerts = false;

  // Notification types
  bool _transactionAlerts = true;
  bool _budgetWarnings = true;
  bool _savingsGoals = false;
  bool _monthlyReports = true;
  bool _billReminders = true;

  // Do Not Disturb
  TimeOfDay _doNotDisturbFrom = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _doNotDisturbTo = const TimeOfDay(hour: 7, minute: 0);

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFrom ? _doNotDisturbFrom : _doNotDisturbTo,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _doNotDisturbFrom = picked;
        } else {
          _doNotDisturbTo = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      localizations.notifications,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // General Notifications Section
              _buildNotificationItem(
                title: localizations.pushNotifications,
                description: localizations.receiveAlertsOnYourDevice,
                value: _pushNotifications,
                onChanged: (value) => setState(() => _pushNotifications = value),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: localizations.emailNotifications,
                description: localizations.receiveUpdatesViaEmail,
                value: _emailNotifications,
                onChanged: (value) => setState(() => _emailNotifications = value),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: localizations.smsAlerts,
                description: localizations.getTextMessageNotifications,
                value: _smsAlerts,
                onChanged: (value) => setState(() => _smsAlerts = value),
              ),
              const SizedBox(height: 32),
              // Notification Types Section
              Text(
                localizations.notificationTypes,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                title: localizations.transactionAlerts,
                description: localizations.whenTransactionIsAdded,
                value: _transactionAlerts,
                onChanged: (value) => setState(() => _transactionAlerts = value),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: localizations.budgetWarnings,
                description: localizations.whenApproachingBudgetLimits,
                value: _budgetWarnings,
                onChanged: (value) => setState(() => _budgetWarnings = value),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: localizations.savingsGoals,
                description: localizations.updatesOnYourSavingsProgress,
                value: _savingsGoals,
                onChanged: (value) => setState(() => _savingsGoals = value),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: localizations.monthlyReports,
                description: localizations.receiveFinancialSummaries,
                value: _monthlyReports,
                onChanged: (value) => setState(() => _monthlyReports = value),
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: localizations.billReminders,
                description: localizations.neverMissAPaymentDeadline,
                value: _billReminders,
                onChanged: (value) => setState(() => _billReminders = value),
              ),
              const SizedBox(height: 32),
              // Do Not Disturb Section
              Text(
                localizations.doNotDisturb,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                localizations.silenceNotificationsDuringSpecificHours,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTimePickerField(
                      context: context,
                      label: localizations.from,
                      time: _doNotDisturbFrom,
                      onTap: () => _selectTime(context, true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTimePickerField(
                      context: context,
                      label: localizations.to,
                      time: _doNotDisturbTo,
                      onTap: () => _selectTime(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _CustomSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickerField({
    required BuildContext context,
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTime(time),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
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
    const double trackWidth = 50.0;
    const double trackHeight = 30.0;
    const double thumbSize = 20.0; // Fixed thumb size for both states
    const double trackPadding = 5.0; // Increased padding for more space

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: trackWidth,
        height: trackHeight,
        decoration: BoxDecoration(
          color: value ? Colors.black : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(trackHeight / 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: trackPadding),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: thumbSize,
              height: thumbSize,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

