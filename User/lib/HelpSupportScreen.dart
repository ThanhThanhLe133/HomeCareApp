import 'package:flutter/material.dart';

import 'ChatBotScreen.dart';
import 'subviews/subviews.dart';

const Color _kAccentColor = Color(0xFF4A6CF7);

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const List<_FaqEntry> _faqs = [
    _FaqEntry(
      question: 'Why is my service booking delayed?',
      answer:
          'Technicians sometimes re-route when earlier jobs run long. You will receive an updated ETA in the app and by SMS.',
    ),
    _FaqEntry(
      question: 'How do I cancel or reschedule?',
      answer:
          'Open the Services tab, tap the booking card, and choose Cancel Visit or Reschedule. Fees are waived when done 2h before dispatch.',
    ),
    _FaqEntry(
      question: 'Can I share device logs with the repair team?',
      answer:
          'Yes. Enable diagnostics sharing in Service Activity settings so technicians can prep parts ahead of time.',
    ),
    _FaqEntry(
      question: 'What if I am not at home during the visit?',
      answer:
          'Toggle “Notify before dispatch” so you can approve the slot or hand off access codes to a trusted person.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Help & support'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          const SectionTitle('Quick answers'),
          const SizedBox(height: 10),
          ..._faqs.map((entry) => _FaqCard(entry: entry)),
          const SizedBox(height: 24),
          const SectionTitle('Contact channels'),
          const SizedBox(height: 10),
          _ContactCard(
            title: 'Call support',
            subtitle: '24/7 hotline · wait time under 2 min',
            icon: Icons.phone_in_talk,
            primaryText: '+1 (415) 555-0108',
            buttonLabel: 'Call now',
            onPressed: () => _showSnack(context, 'Calling support...'),
          ),
          const SizedBox(height: 12),
          _ContactCard(
            title: 'WhatsApp & SMS',
            subtitle: 'Send photos or status updates',
            icon: Icons.chat_bubble_outline,
            primaryText: '+1 (415) 555-0199',
            buttonLabel: 'Message us',
            onPressed: () => _showSnack(context, 'Opening chat thread...'),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Need more help?'),
          const SizedBox(height: 10),
          _SupportActions(
            onChatTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ChatBotScreen()));
            },
          ),
        ],
      ),
    );
  }

  static void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _FaqCard extends StatefulWidget {
  const _FaqCard({required this.entry});

  final _FaqEntry entry;

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7EAF3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        title: Text(
          widget.entry.question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          _expanded ? Icons.remove_circle_outline : Icons.add_circle_outline,
          color: _kAccentColor,
        ),
        onExpansionChanged: (value) => setState(() => _expanded = value),
        children: [
          Text(
            widget.entry.answer,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryText,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String primaryText;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7EAF3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFEFF3FF),
            child: Icon(icon, color: _kAccentColor, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                Text(
                  primaryText,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: _kAccentColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}

class _SupportActions extends StatelessWidget {
  const _SupportActions({required this.onChatTap});

  final VoidCallback onChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chat with our assistant for device-specific help.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onChatTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kAccentColor,
                    side: const BorderSide(color: _kAccentColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Chat with assistant'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  onPressed: () => HelpSupportScreen._showSnack(
                    context,
                    'Help center articles coming soon',
                  ),
                  child: const Text('Browse articles'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FaqEntry {
  const _FaqEntry({required this.question, required this.answer});

  final String question;
  final String answer;
}
