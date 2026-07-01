import 'dart:async';
import 'dart:math';

class ChatMessage {
  final String id;
  final String text;
  final bool isFromUser;
  final DateTime timestamp;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
    this.isRead = false,
  });

  ChatMessage copyWith({bool? isRead}) => ChatMessage(
        id: id,
        text: text,
        isFromUser: isFromUser,
        timestamp: timestamp,
        isRead: isRead ?? this.isRead,
      );
}

class ChatSimulationService {
  final _controller = StreamController<List<ChatMessage>>.broadcast();
  final List<ChatMessage> _messages = [];
  final _random = Random();
  Timer? _replyTimer;

  /// Whether the lawyer is currently "typing"
  final _typingController = StreamController<bool>.broadcast();
  Stream<bool> get typingStream => _typingController.stream;

  Stream<List<ChatMessage>> get messageStream => _controller.stream;
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  static const List<String> _lawyerReplies = [
    'I have reviewed your query. This is a common situation in Pakistani law and there are several approaches we can take.',
    'Thank you for sharing the details. Based on what you have described, I would recommend we proceed with filing an application.',
    'The hearing is scheduled for next week. I will prepare all necessary documentation before then.',
    'I understand your concern. Let me explain the legal options available to you in this matter.',
    'This type of case typically takes 3-6 months in the sessions court. I will keep you updated at every stage.',
    'The evidence you have mentioned is very important. Please bring all original documents to our next meeting.',
    'I have filed the petition. We should expect a response from the court within 15 working days.',
    'Your case is progressing well. The opposing party has been served with the notice.',
    'I need to review the property documents before advising further. Can you send me scanned copies?',
    'The court has fixed the next hearing. Your presence is required at 10 AM.',
    'I am working on drafting the reply to the notice. It will be ready by tomorrow.',
    'Please do not worry. We have strong grounds in this case and the law is on your side.',
    'I spoke with the opposing counsel today. They are open to an out-of-court settlement. Shall I explore this option?',
    'The judge has asked for additional documents. I will compile them and submit by the deadline.',
    'Good news — the court has accepted our application. We should get a favourable order soon.',
  ];

  void sendMessage(String text) {
    final msg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isFromUser: true,
      timestamp: DateTime.now(),
    );
    _messages.add(msg);
    _controller.add(List.from(_messages));
    _scheduleReply();
  }

  void _scheduleReply() {
    _replyTimer?.cancel();
    final typingDelay = 1500 + _random.nextInt(2000);
    final replyDelay = typingDelay + 1500 + _random.nextInt(3000);

    // Show typing indicator
    Future.delayed(Duration(milliseconds: typingDelay), () {
      if (!_typingController.isClosed) {
        _typingController.add(true);
      }
    });

    // Send reply
    _replyTimer = Timer(Duration(milliseconds: replyDelay), () {
      if (!_typingController.isClosed) {
        _typingController.add(false);
      }
      if (!_controller.isClosed) {
        final reply = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _lawyerReplies[_random.nextInt(_lawyerReplies.length)],
          isFromUser: false,
          timestamp: DateTime.now(),
          isRead: false,
        );
        _messages.add(reply);
        _controller.add(List.from(_messages));
      }
    });
  }

  void markAllRead() {
    for (int i = 0; i < _messages.length; i++) {
      if (!_messages[i].isFromUser && !_messages[i].isRead) {
        _messages[i] = _messages[i].copyWith(isRead: true);
      }
    }
    _controller.add(List.from(_messages));
  }

  Stream<String> simulateResponse(String prompt, {bool isStudent = false}) async* {
    final sentences = isStudent 
      ? [
          'Based on the latest Pakistani jurisprudence, ',
          'the relevant section of the Penal Code states that ',
          'you must file an application under Section 156(3) CrPC. ',
          'Would you like me to elaborate on the legal precedents?'
        ]
      : [
          'I have analyzed the query. ',
          'The best course of action is to draft a legal notice. ',
          'Ensure you include all material facts in the draft. ',
          'Let me know if you need a template.'
        ];
    
    for (var s in sentences) {
      await Future.delayed(Duration(milliseconds: 400 + _random.nextInt(600)));
      yield s;
    }
  }

  void dispose() {
    _replyTimer?.cancel();
    _controller.close();
    _typingController.close();
  }
}
