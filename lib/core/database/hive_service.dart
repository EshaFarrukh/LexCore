import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static const String _settingsBox = 'settings';
  static const String _messagesBox = 'messages';
  static const String _appointmentsBox = 'appointments';
  static const String _paymentsBox = 'payments';
  static const String _notificationsBox = 'notifications';
  static const String _bookmarksBox = 'bookmarks';

  // Settings keys
  static const String kThemeMode = 'theme_mode';
  static const String kAuthToken = 'auth_token';
  static const String kUserId = 'user_id';
  static const String kUserRole = 'user_role';
  static const String kUserName = 'user_name';
  static const String kBiometricEnabled = 'biometric_enabled';
  static const String kNotificationsEnabled = 'notifications_enabled';
  static const String kLanguage = 'language';
  static const String kOnboardingComplete = 'onboarding_complete';

  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDir.path);
    await Hive.openBox(_settingsBox);
    await Hive.openBox(_messagesBox);
    await Hive.openBox(_appointmentsBox);
    await Hive.openBox(_paymentsBox);
    await Hive.openBox(_notificationsBox);
    await Hive.openBox(_bookmarksBox);
  }

  // === Settings ===
  static Box get _settings => Hive.box(_settingsBox);

  static Future<void> saveSetting(String key, dynamic value) async {
    await _settings.put(key, value);
  }

  static T? getSetting<T>(String key, {T? defaultValue}) {
    return _settings.get(key, defaultValue: defaultValue) as T?;
  }

  // === Auth ===
  static Future<void> saveAuthToken(String token) async {
    await _settings.put(kAuthToken, token);
  }

  static String? getAuthToken() => _settings.get(kAuthToken);

  static Future<void> saveUserInfo({
    required String userId,
    required String role,
    required String name,
  }) async {
    await _settings.put(kUserId, userId);
    await _settings.put(kUserRole, role);
    await _settings.put(kUserName, name);
  }

  static String? getUserRole() => _settings.get(kUserRole);
  static String? getUserId() => _settings.get(kUserId);
  static String? getUserName() => _settings.get(kUserName);

  static Future<void> clearAuth() async {
    await _settings.delete(kAuthToken);
    await _settings.delete(kUserId);
    await _settings.delete(kUserRole);
    await _settings.delete(kUserName);
  }

  // === Bookmarks (news articles) ===
  static Box get _bookmarks => Hive.box(_bookmarksBox);

  static Future<void> bookmarkArticle(String articleId) async {
    await _bookmarks.put(articleId, true);
  }

  static Future<void> unbookmarkArticle(String articleId) async {
    await _bookmarks.delete(articleId);
  }

  static bool isBookmarked(String articleId) {
    return _bookmarks.get(articleId, defaultValue: false) as bool;
  }

  static List<String> getBookmarkedIds() {
    return _bookmarks.keys.cast<String>().toList();
  }

  // === Appointments ===
  static Box get _appointments => Hive.box(_appointmentsBox);

  static Future<void> saveAppointment(Map<String, dynamic> appointment) async {
    await _appointments.put(appointment['id'], appointment);
  }

  static List<Map> getAllAppointments() {
    return _appointments.values.cast<Map>().toList();
  }

  // === Payments ===
  static Box get _payments => Hive.box(_paymentsBox);

  static Future<void> savePayment(Map<String, dynamic> payment) async {
    await _payments.put(payment['id'], payment);
  }

  static List<Map> getAllPayments() {
    return _payments.values.cast<Map>().toList();
  }

  // === Notifications ===
  static Box get _notifications => Hive.box(_notificationsBox);

  static Future<void> saveNotification(Map<String, dynamic> notification) async {
    await _notifications.put(notification['id'], notification);
  }

  static List<Map> getAllNotifications() {
    return _notifications.values.cast<Map>().toList().reversed.toList();
  }

  static Future<void> markNotificationRead(String id) async {
    final notification = _notifications.get(id);
    if (notification != null) {
      final updated = Map.from(notification);
      updated['isRead'] = true;
      await _notifications.put(id, updated);
    }
  }

  static int getUnreadCount() {
    return _notifications.values.where((n) => !(n['isRead'] as bool? ?? false)).length;
  }
}
