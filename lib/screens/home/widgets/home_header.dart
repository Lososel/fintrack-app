import 'package:flutter/material.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/screens/search/search_results_screen.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _userService.addListener(_refresh);
  }

  @override
  void dispose() {
    _userService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  String _getTimeBasedGreeting(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final now = DateTime.now();

    // Adjust for user's timezone if location is available
    DateTime localTime = now;
    if (_userService.latitude != null && _userService.longitude != null) {
      // For simplicity, we'll use the device timezone
      // In a production app, you'd convert based on the user's coordinates
      localTime = now;
    }

    final localHour = localTime.hour;

    if (localHour >= 5 && localHour < 12) {
      return localizations.goodMorning;
    } else if (localHour >= 12 && localHour < 17) {
      return localizations.goodAfternoon;
    } else if (localHour >= 17 && localHour < 21) {
      return localizations.goodEvening;
    } else {
      return localizations.goodNight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final name = _userService.name ?? localizations.user;
    final greeting = _getTimeBasedGreeting(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$greeting, $name.",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        IconButton(
          icon: Icon(Icons.search, color: iconColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchResultsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
