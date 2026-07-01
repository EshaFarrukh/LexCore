class RouteNames {
  RouteNames._();

  // === Auth ===
  static const splashScreen = '/';
  static const onboardingScreen = '/onboarding';
  static const roleOverviewScreen = '/role-overview';
  static const incomingUserScreen = '/role-select';
  static const loginScreen = '/login';
  static const signupScreen = '/signup';
  static const forgotPasswordScreen = '/forgot-password';
  static const otpScreen = '/otp';
  static const resetPasswordScreen = '/reset-password';

  // === Client ===
  static const bottomNavigationScreen = '/client/home';
  static const homeScreen = '/client/home/cases';
  static const chatScreen = '/client/chat';
  static const chatDetailScreen = '/client/chat/:chatId';
  static const videoScreen = '/client/video';
  static const videoConsultationScreen = '/client/video-call';
  static const searchScreen = '/client/search';
  static const notificationScreen = '/client/notifications';
  static const lawyerScreen = '/client/lawyer/:lawyerId';
  static const lawyerProfileScreen = '/client/lawyer-profile';
  static const appointmentBookingScreen = '/client/appointment';
  static const appointmentConfirmedScreen = '/client/appointment-confirmed';
  static const courtMapScreen = '/client/court-map';
  static const courtInfoScreen = '/client/court-info';
  static const supportFormScreen = '/client/support';
  static const aiAssistantScreen = '/client/ai-assistant';
  static const legalNewsScreen = '/client/news';
  static const newsArticleScreen = '/client/news/:articleId';
  static const donationScreen = '/client/donate';
  static const paymentHistoryScreen = '/client/payment-history';
  static const documentVaultScreen = '/client/documents';
  static const documentScannerScreen = '/client/scan';
  static const eSignatureScreen = '/client/sign';
  static const pdfViewerScreen = '/pdf-viewer';
  static const clientProfileScreen = '/client/profile';
  static const clientSettingsScreen = '/client/settings';
  static const reviewRateScreen = '/client/review';
  static const caseDetailScreen = '/client/case/:caseId';
  static const caseTimelineScreen = '/client/case-timeline/:caseId';
  static const newCaseWizardScreen = '/client/new-case';

  // === Lawyer ===
  static const lawyerDashboardScreen = '/lawyer/dashboard';
  static const lawyerBottomNavigationScreen = '/lawyer/home';
  static const lawyerAnalyticsScreen = '/lawyer/analytics';
  static const lawyerCalendarScreen = '/lawyer/calendar';
  static const lawyerClientListScreen = '/lawyer/clients';
  static const lawyerCaseDetailScreen = '/lawyer/case/:caseId';
  static const lawyerDocumentManagerScreen = '/lawyer/documents';
  static const lawyerEarningsScreen = '/lawyer/earnings';
  static const lawyerSubscriptionScreen = '/lawyer/subscription';
  static const lawyerVideoConsultScreen = '/lawyer/video-call';
  static const lawyerReviewsScreen = '/lawyer/reviews';
  static const lawyerPrfoileScreen = '/lawyer/profile';
  static const lawyerSettingsScreen = '/lawyer/settings';
  static const lawyerSignupScreen = '/lawyer/signup';
  static const lawyerloginScreen = '/lawyer/login';
  static const chatListScreen = '/lawyer/chats';

  // === Student ===
  static const studentBottomNavigationScreen = '/student/home';
  static const studentDashboardScreen = '/student/dashboard';
  static const certificationScreen = '/student/certifications';
  static const certificationDetailScreen = '/student/certification/:id';
  static const tasksScreen = '/student/tasks';
  static const researchScreen = '/student/research';
  static const researchDetailScreen = '/student/research/:id';
  static const studentProfileScreen = '/student/profile';
  static const studentSettingsScreen = '/student/settings';
  static const helpSupportScreen = '/student/help';
  static const internshipScreen = '/student/internships';
  static const internshipDetailScreen = '/student/internship/:id';
  static const programsScreen = '/student/programs';
  static const studentSignupScreen = '/student/signup';
  static const studentLoginScreen = '/student/login';
  static const studentAiAssistantScreen = '/student/ai-study';
  static const certificateViewerScreen = '/student/certificate-viewer';

  // === Shared ===
  static const errorScreen = '/error';
  static const noInternetScreen = '/no-internet';
}
