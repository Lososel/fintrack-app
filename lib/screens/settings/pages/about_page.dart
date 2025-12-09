import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          'About',
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
                  _SectionHeader('Personal Finance Manager'),
                  SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 12),
                  _BodyText(
                    'Your trusted companion for managing personal finances and '
                    'achieving financial freedom. Track your spending, set budgets, '
                    'and monitor your progress toward your goals in one simple app.',
                  ),
                  SizedBox(height: 32),
                  _SectionHeader('Made with Love'),
                  SizedBox(height: 8),
                  _GithubRow(),
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

class _SectionHeader extends StatelessWidget {
  final String text;

  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
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

class _GithubRow extends StatelessWidget {
  const _GithubRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'GitHub',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 4),
        Icon(
          Icons.open_in_new,
          size: 16,
          color: Colors.black87,
        ),
      ],
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