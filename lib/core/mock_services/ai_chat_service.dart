import 'dart:async';
import 'dart:math';
import '../local_data/legal_qa_pairs.dart';

class AIChatService {
  static final AIChatService _instance = AIChatService._internal();
  factory AIChatService() => _instance;
  AIChatService._internal();

  final Random _random = Random();

  /// Returns a stream that emits progressively longer substrings (typing effect)
  Stream<String> getResponse(String userMessage) async* {
    // Simulate thinking delay
    await Future.delayed(Duration(milliseconds: 800 + _random.nextInt(1200)));

    final response = _findBestResponse(userMessage.toLowerCase().trim());

    // Stream character by character
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(Duration(milliseconds: 10 + _random.nextInt(10)));
      yield response.substring(0, i + 1);
    }
  }

  /// Synchronous version — returns full response immediately after delay
  Future<String> getFullResponse(String userMessage) async {
    await Future.delayed(Duration(milliseconds: 800 + _random.nextInt(1200)));
    return _findBestResponse(userMessage.toLowerCase().trim());
  }

  String _findBestResponse(String query) {
    // Check for greeting
    if (LegalQA.greetingKeywords.any((k) => query.contains(k))) {
      return LegalQA.greetingResponse;
    }

    // Find best matching Q&A pair by keyword score
    LegalQAPair? bestMatch;
    int bestScore = 0;

    for (final pair in LegalQA.pairs) {
      int score = 0;
      for (final keyword in pair.keywords) {
        if (query.contains(keyword)) {
          score += keyword.length; // longer keyword match = higher relevance
        }
      }
      if (score > bestScore) {
        bestScore = score;
        bestMatch = pair;
      }
    }

    return (bestMatch != null && bestScore > 0)
        ? bestMatch.response
        : LegalQA.defaultResponse;
  }
}
