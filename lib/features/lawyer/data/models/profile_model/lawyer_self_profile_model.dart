class LawyerSelfProfileModel {
  final String fullName;
  final String title;
  final String location;
  final int yearsOfPractice;
  final int casesHandled;
  final double overallWinRate; // 0.0 - 1.0
  final int activeMatters;
  final List<String> practiceAreas;
  final String about;
  final String email;
  final String phone;
  final String officeHours;
  final String profileImage;

  LawyerSelfProfileModel({
    required this.fullName,
    required this.title,
    required this.location,
    required this.yearsOfPractice,
    required this.casesHandled,
    required this.overallWinRate,
    required this.activeMatters,
    required this.practiceAreas,
    required this.about,
    required this.email,
    required this.phone,
    required this.officeHours,
    required this.profileImage,
  });

  factory LawyerSelfProfileModel.fromJson(Map<String, dynamic> json, {String? fullName, String? email, String? phone}) {
    final stats = json['stats'] as Map<String, dynamic>? ?? {};
    final resolved = stats['resolvedCases'] as int? ?? 0;
    final active = stats['activeCases'] as int? ?? 0;
    final total = resolved + active;
    final winRate = total > 0 ? resolved / total : 0.0;

    final expString = json['experience'] as String? ?? '0';
    final expValue = int.tryParse(expString.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    return LawyerSelfProfileModel(
      fullName: fullName ?? json['fullName'] as String? ?? 'Unknown',
      title: json['title'] as String? ?? 'Lawyer',
      location: json['location'] as String? ?? 'Unknown',
      yearsOfPractice: expValue,
      casesHandled: total,
      overallWinRate: winRate,
      activeMatters: active,
      practiceAreas: List<String>.from(json['specializations'] ?? []),
      about: json['about'] as String? ?? '',
      email: email ?? json['email'] as String? ?? '',
      phone: phone ?? json['phone'] as String? ?? '',
      officeHours: json['availability'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
    );
  }
}
