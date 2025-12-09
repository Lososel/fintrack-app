import 'package:flutter/material.dart';

class HelpAndFaqPage extends StatefulWidget {
  const HelpAndFaqPage({super.key});

  @override
  State<HelpAndFaqPage> createState() => _HelpAndFaqPageState();
}

class _HelpAndFaqPageState extends State<HelpAndFaqPage> {
  late final List<_FaqSection> _sections;

  @override
  void initState() {
    super.initState();

    _sections = [
      _FaqSection(
        title: 'Getting started',
        items: [
          _FaqItem(
            question: 'How do I add my first transaction?',
            answer:
                'Tap the “Add transaction” button on the home screen, choose a '
                'category, enter the amount and any notes, then save. Your new '
                'transaction will appear immediately in your list and analytics.',
          ),
          _FaqItem(
            question: 'How do I create a budget?',
            answer:
                'Go to the Budget section, tap “Create budget”, pick a category, '
                'set an amount and a time period, then confirm. We’ll track your '
                'spending against this limit automatically.',
          ),
        ],
      ),
      _FaqSection(
        title: 'Features',
        items: [
          _FaqItem(
            question: 'How does the currency converter work?',
            answer:
                'When you enter an expense in a different currency, the app uses '
                'live exchange rates to convert it to your base currency. You can '
                'change your base currency in Settings.',
          ),
        ],
      ),
      _FaqSection(
        title: 'Categories',
        items: [
          _FaqItem(
            question: 'Can I create custom categories?',
            answer:
                'Yes. Open the Categories or Manage Categories section, tap '
                '“Add category”, choose an icon and a name, then save.',
          ),
          _FaqItem(
            question: 'How do I edit or delete a category?',
            answer:
                'In the Manage Categories screen, tap on a category to rename or '
                'change its icon. Long-press or use the options menu to delete it. '
                'Transactions using that category will remain but be marked as uncategorised.',
          ),
        ],
      ),
      _FaqSection(
        title: 'Analytics',
        items: [
          _FaqItem(
            question: 'What reports are available?',
            answer:
                'You can view spending by category, time period, and trends over '
                'time. Open the Analytics tab to switch between report types.',
          ),
        ],
      ),
      _FaqSection(
        title: 'Security',
        items: [
          _FaqItem(
            question: 'Is my financial data secure?',
            answer:
                'Your data is stored locally on your device. We do not upload your '
                'transactions or budgets to our servers. Use your device lock and '
                'biometric features for extra protection.',
          ),
          _FaqItem(
            question: 'Can I password protect the app?',
            answer:
                'Yes. In Settings, enable app lock using your device PIN, Face ID, '
                'or fingerprint. After that, the app will require authentication '
                'each time it is opened.',
          ),
        ],
      ),
    ];
  }

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
          'Help and FAQ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const Text(
                'Help and FAQ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              ..._buildSections(),
              const SizedBox(height: 24),
              _ContactUsBanner(
                onTap: () {
                  // TODO: open email client (url_launcher) or support screen
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _SettingsBottomNav(),
    );
  }

  List<Widget> _buildSections() {
    final List<Widget> widgets = [];

    for (final section in _sections) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            section.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      );

      for (final item in section.items) {
        widgets.add(
          _FaqCard(
            item: item,
            onToggle: () {
              setState(() => item.isExpanded = !item.isExpanded);
            },
          ),
        );
        widgets.add(const SizedBox(height: 8));
      }

      widgets.add(const SizedBox(height: 16));
    }

    return widgets;
  }
}

class _FaqSection {
  final String title;
  final List<_FaqItem> items;

  _FaqSection({required this.title, required this.items});
}

class _FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  _FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class _FaqCard extends StatelessWidget {
  final _FaqItem item;
  final VoidCallback onToggle;

  const _FaqCard({
    required this.item,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.question,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: item.isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  item.answer,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF5A5A5A),
                  ),
                ),
              ),
              crossFadeState: item.isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactUsBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _ContactUsBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Contact us: ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              'support@spendly.kz',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
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