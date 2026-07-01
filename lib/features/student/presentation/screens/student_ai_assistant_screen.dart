import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/mock_services/chat_simulation_service.dart';

class StudentAiAssistantScreen extends StatefulWidget {
  const StudentAiAssistantScreen({super.key});

  @override
  State<StudentAiAssistantScreen> createState() => _StudentAiAssistantScreenState();
}

class _StudentAiAssistantScreenState extends State<StudentAiAssistantScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  late final ChatSimulationService _sim;

  @override
  void initState() {
    super.initState();
    _sim = ChatSimulationService();
    _messages.add({
      'role': 'assistant',
      'text': 'Hello! I am LexTutor, your AI legal studies assistant. I can help you understand case law, draft mock arguments, or prepare for exams. What topic shall we cover today?',
      'streaming': false,
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text, 'streaming': false});
      _isTyping = true;
    });
    _ctrl.clear();
    _scrollToBottom();

    // Create placeholder for assistant message
    final msgIndex = _messages.length;
    setState(() {
      _messages.add({'role': 'assistant', 'text': '', 'streaming': true});
    });

    final stream = _sim.simulateResponse(text, isStudent: true);
    String fullResponse = '';

    await for (final chunk in stream) {
      if (!mounted) return;
      fullResponse += chunk;
      setState(() {
        _messages[msgIndex]['text'] = fullResponse;
      });
      _scrollToBottom();
    }

    if (mounted) {
      setState(() {
        _messages[msgIndex]['streaming'] = false;
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.kSuccessGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LexTutor AI', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 16)),
                Text('Powered by LexCore', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.kTextSecondary)),
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                final isStreaming = msg['streaming'] as bool;

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.kSuccess : AppColors.kBgSurface,
                      borderRadius: BorderRadius.circular(20).copyWith(
                        bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20),
                        bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4),
                      ),
                      border: isUser ? null : Border.all(color: AppColors.kBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            msg['text'],
                            style: GoogleFonts.plusJakartaSans(
                              color: isUser ? Colors.white : AppColors.kTextPrimary,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                        if (isStreaming)
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 2),
                            child: Container(
                              width: 8, height: 16, color: AppColors.kSuccess,
                            ).animate(onPlay: (c) => c.repeat(reverse: true)).fade(duration: 300.ms),
                          ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1),
                );
              },
            ),
          ),

          // Input area
          Container(
            padding: EdgeInsets.only(
              left: 20, right: 20, top: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.kBgSurface,
              border: const Border(top: BorderSide(color: AppColors.kBorder)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.kBgElevated,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.kBorder),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      style: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 14),
                      maxLines: 3,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Ask your tutor...',
                        hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _isTyping ? null : _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: _isTyping ? null : AppColors.kSuccessGradient,
                      color: _isTyping ? AppColors.kBgElevated : null,
                      shape: BoxShape.circle,
                    ),
                    child: _isTyping
                        ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.kSuccess, strokeWidth: 2)))
                        : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
