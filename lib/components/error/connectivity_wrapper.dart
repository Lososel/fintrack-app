import 'package:flutter/material.dart';
import 'package:fintrack_app/screens/error/error_screen.dart';
import 'package:fintrack_app/services/connectivity_service.dart';

/// A wrapper widget that shows an error screen when there's no internet connection
class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  final ConnectivityService? connectivityService;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.connectivityService,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late ConnectivityService _connectivityService;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _connectivityService = widget.connectivityService ?? ConnectivityService();
    _connectivityService.addListener(_onConnectivityChanged);
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    await _connectivityService.checkConnectivity();
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  void _onConnectivityChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Only dispose if we created the service
    if (widget.connectivityService == null) {
      _connectivityService.dispose();
    } else {
      _connectivityService.removeListener(_onConnectivityChanged);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      // Show loading or the child while checking connectivity
      return widget.child;
    }

    if (!_connectivityService.isConnected) {
      return ErrorScreen(
        isNoConnection: true,
        onRetry: () {
          _connectivityService.checkConnectivity();
        },
      );
    }

    return widget.child;
  }
}

