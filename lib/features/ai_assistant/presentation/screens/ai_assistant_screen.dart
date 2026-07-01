import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/mock_services/ai_chat_service.dart';

class _ChatMsg {
  final String text;
  final bool isUser;
  final DateTime time;
  _ChatMsg({required this.text, required this.isUser, DateTime? time})
      : time = time ?? DateTime.now();
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _chatService = AIChatService();
  final List<_ChatMsg> _messages = [];
  bool _isTyping = false;
  String _currentAiText = '';
  StreamSubscription<String>? _aiStreamSub;

  static const _suggestedQuestions = [
    'How do I file a bail application?',
    'What is the FIR procedure?',
    'How does property inheritance work?',
    'What are my tenant rights?',
    'How does Khula divorce work?',
    'What are cybercrime laws in Pakistan?',
  ];

  @override
  void initState() {
    super.initState();
    // Initial greeting
    _messages.add(_ChatMsg(
      text: 'Assalam-o-Alaikum! 👋 I am your LexCore Legal Assistant.\n\nI can help you understand Pakistani law and legal procedures. Ask me about bail, FIRs, property disputes, divorce, contracts, inheritance, or any other legal matter.\n\nHow can I assist you today?',
      isUser: false,
    ));
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _aiStreamSub?.cancel();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();

    setState(() {
      _messages.add(_ChatMsg(text: text.trim(), isUser: true));
      _isTyping = true;
      _currentAiText = '';
    });
    _scrollToBottom();

    _aiStreamSub?.cancel();
    _aiStreamSub = _chatService.getResponse(text).listen(
      (partial) {
        setState(() => _currentAiText = partial);
        _scrollToBottom();
      },
      onDone: () {
        setState(() {
          _messages.add(_ChatMsg(text: _currentAiText, isUser: false));
          _currentAiText = '';
          _isTyping = false;
        });
        _scrollToBottom();
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.kBrandGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.psychology_rounded, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LexCore AI',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                Text('Legal Assistant',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11, color: AppColors.kSuccess, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.kBrand.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.kBrand.withOpacity(0.3)),
            ),
            child: Text('AI',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.kBrand)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length +
                  (_isTyping && _currentAiText.isNotEmpty ? 1 : 0) +
                  (_isTyping && _currentAiText.isEmpty ? 1 : 0) +
                  (_messages.length == 1 ? 1 : 0), // suggestions
              itemBuilder: (context, index) {
                // Greeting message
                if (index == 0) {
                  return _buildAiBubble(_messages[0].text).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
                }

                // Suggestions card (after greeting, before any user message)
                if (_messages.length == 1 && index == 1) {
                  return _buildSuggestionsCard()
                      .animate(delay: 200.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1);
                }

                final adjustedIndex = _messages.length == 1 ? index - 1 : index;

                // Existing messages
                if (adjustedIndex < _messages.length) {
                  final msg = _messages[adjustedIndex];
                  if (adjustedIndex == 0) return _buildAiBubble(msg.text); // already handled above
                  return msg.isUser
                      ? _buildUserBubble(msg.text).animate().fadeIn(duration: 200.ms).slideX(begin: 0.05)
                      : _buildAiBubble(msg.text).animate().fadeIn(duration: 200.ms).slideX(begin: -0.05);
                }

                // Typing / streaming
                if (_isTyping && _currentAiText.isNotEmpty) {
                  return _buildAiBubble(_currentAiText, isStreaming: true);
                }

                // Thinking dots
                return _buildThinkingDots();
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildSuggestionsCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kBgElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Suggested Questions',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.kTextSecondary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestedQuestions.map((q) {
              return GestureDetector(
                onTap: () => _sendMessage(q),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.kBrand.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.kBrand.withOpacity(0.25)),
                  ),
                  child: Text(q,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, color: AppColors.kBrandLight, fontWeight: FontWeight.w500)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 60),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: AppColors.kBrandGradient,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Text(text,
            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.white, height: 1.5)),
      ),
    );
  }

  Widget _buildAiBubble(String text, {bool isStreaming = false}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: AppColors.kBrandGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.psychology_rounded, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12, right: 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.kBgElevated,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(text,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, color: AppColors.kTextPrimary, height: 1.5)),
                  ),
                  if (isStreaming) ...[
                    const SizedBox(width: 4),
                    Container(
                      width: 6,
                      height: 14,
                      color: AppColors.kBrand,
                    ).animate(onPlay: (c) => c.repeat()).fadeIn(duration: 500.ms).then().fadeOut(duration: 500.ms),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThinkingDots() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: AppColors.kBrandGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.psychology_rounded, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.kBgElevated,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.kBrand,
                    shape: BoxShape.circle,
                  ),
                )
                    .animate(delay: (i * 200).ms, onPlay: (c) => c.repeat(reverse: true))
                    .scaleXY(end: 0.5, duration: 600.ms);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface,
        border: Border(top: BorderSide(color: AppColors.kBorder)),
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
                controller: _textController,
                style: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Ask a legal question...',
                  hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _sendMessage(_textController.text),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: AppColors.kBrandGradient,
                borderRadius: BorderRadius.circular(23),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
