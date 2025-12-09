import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF5F5F7);

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
          'Privacy Policy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 8),
                  _SectionTitle('Information We Collect'),
                  SizedBox(height: 4),
                  _BodyText(
                    'Personal Finance Manager only collects information that you '
                    'explicitly provide, such as your name, email (for authentication), '
                    'and the financial data you enter (transactions, budgets, categories). '
                    'This information is stored locally on your device.',
                  ),
                  SizedBox(height: 16),
                  _SectionTitle('How We Use Your Information'),
                  SizedBox(height: 4),
                  _BodyText(
                    'Your information is used solely to provide the app’s functionality – '
                    'tracking your finances, generating insights, and helping you manage '
                    'your budget. We do not use your data for any other purpose.',
                  ),
                  SizedBox(height: 16),
                  _SectionTitle('Data Storage'),
                  SizedBox(height: 4),
                  _BodyText(
                    'All data is stored in your device’s local storage. This means your '
                    'data stays on your device and is not transmitted to our servers. '
                    'If you clear your device or uninstall the app, your financial data '
                    'will be removed.',
                  ),
                  SizedBox(height: 16),
                  _SectionTitle('Data Security'),
                  SizedBox(height: 4),
                  _BodyText(
                    'We take security seriously. While we use local storage which is '
                    'generally secure, we recommend using the security features provided '
                    'by your device, such as a device passcode or biometric authentication, '
                    'to further protect your information.',
                  ),
                  SizedBox(height: 16),
                  _SectionTitle('Third-Party Services'),
                  SizedBox(height: 4),
                  _BodyText(
                    'Certain features, like currency conversion, may use external APIs '
                    'to fetch real-time data. These services do not have access to your '
                    'personal financial data – only to the currency codes and amounts '
                    'needed for conversion.',
                  ),
                  SizedBox(height: 120), // space above bottom curve
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: CustomPaint(
                  painter: _BottomWavePainter(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _SettingsBottomNav(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;

  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 14,
        height: 1.4,
        color: Color(0xFF424242),
      ),
    );
  }
}

class _BottomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE1E3EA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.55,
      size.width * 0.5,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.65,
      size.width,
      size.height * 0.5,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SettingsBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 3,
      onTap: (_) {
        // TODO: hook up navigation to main tabs if needed
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Budget',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}