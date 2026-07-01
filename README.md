<div align="center">
  <img src="assets/images/logo.png" width="120" alt="LexCore Logo" />
  <h1>LexCore</h1>
  <p><strong>Your Legal Command Center — A comprehensive, production-grade LegalTech platform.</strong></p>

  <p>
    <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
    <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
    <img src="https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=firebase&logoColor=white" alt="Firebase" />
    <img src="https://img.shields.io/badge/Riverpod-State%20Management-blueviolet?style=for-the-badge" alt="Riverpod" />
    <img src="https://img.shields.io/badge/Clean%20Architecture-Solid-success?style=for-the-badge" alt="Clean Architecture" />
  </p>
  <p>
    <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey?style=for-the-badge" alt="Platform" />
    <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License" />
    <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge" alt="Version" />
  </p>
</div>

---

## 📖 Overview

**LexCore** is a comprehensive, production-ready LegalTech platform designed to bridge the gap between clients seeking legal assistance, lawyers managing their practice, and law students advancing their education. 

Built with enterprise-grade architecture, LexCore solves the fragmentation of the legal industry by providing a unified ecosystem. The platform consists of three tailored experiences seamlessly integrated into a single application:

1. **Client Portal:** Empowers individuals to discover specialized lawyers, book consultations, and track case progress in real-time.
2. **Lawyer Portal:** Equips legal professionals with a robust CRM to manage caseloads, schedules, client communications, and digital documents.
3. **Student Portal:** Provides law students with a dedicated learning environment, offering interactive mock trials, specialized certifications, and extensive legal research tools.

By centralizing these experiences, LexCore eliminates friction, increases transparency, and democratizes access to legal resources.

---

## ✨ Features

LexCore is packed with advanced features designed for scale and reliability, grouped by core domain:

### 🔐 Authentication & Onboarding
- **Role-Based Access Control (RBAC):** Distinct application flows tailored specifically for Clients, Lawyers, and Students upon login.
- **Secure Authentication:** Enterprise-grade security utilizing Firebase Authentication.
- **Premium Onboarding:** High-quality, animated onboarding sequences introducing users to platform capabilities.

### 💼 Lawyer Discovery & Booking
- **Smart Search Engine:** Find lawyers by specialization, location, and rating using optimized search algorithms.
- **Interactive Maps:** Geospatial lawyer discovery using integrated maps.
- **Appointment Booking:** Real-time schedule synchronization and seamless consultation booking.

### 📁 Case & Practice Management
- **Lawyer Dashboard:** A sophisticated command center for tracking pending and disposed cases.
- **Bento Box Analytics:** Beautifully visualized data summaries of lawyer performance and case statistics.
- **Document Management:** Securely view, sign, and manage legal PDFs and evidence directly within the app.

### 🎓 Law Student Learning Ecosystem
- **Certification Modules:** Track progress across diverse legal specializations (e.g., Cybercrime & Digital Evidence).
- **Interactive Mock Trials:** Participate in simulated scenarios to hone litigation skills.
- **Extensive Legal Research:** Gain access to an expansive library of case studies and precedent files.

### 💬 Communication & Engagement
- **Real-time Chat:** Secure, instantaneous messaging between clients and lawyers.
- **Video Consultations:** Built-in video conferencing capabilities for remote hearings and meetings.
- **Smart Notifications:** Push notifications for upcoming hearings, new messages, and status updates.

### 🎨 Premium UI/UX Design
- **Material 3 Design System:** Adhering to the latest design guidelines for a native feel on iOS and Android.
- **Fluid Micro-animations:** High-performance animations using `flutter_animate` and Lottie to delight users.
- **Responsive Architecture:** flawless rendering across mobile devices and tablets.

---

## 📸 Screenshots

LexCore features a world-class design system. Here is a glimpse into the application's interface:

### Onboarding & Authentication
| Splash Screen | Onboarding 1 | Onboarding 2 | Onboarding 3 |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/Splash Screen.png" width="200"/> | <img src="assets/screenshots/Onboarding Screen 1.png" width="200"/> | <img src="assets/screenshots/Onboarding Screen 2.png" width="200"/> | <img src="assets/screenshots/Onboarding Screen 3.png" width="200"/> |

| Role Selection | Choose Role | Login |
|:---:|:---:|:---:|
| <img src="assets/screenshots/Role Selection Screen.png" width="200"/> | <img src="assets/screenshots/Choose Role Screen.png" width="200"/> | <img src="assets/screenshots/Login Screen .png" width="200"/> |

### Portals & Dashboards
| Lawyer Dashboard | Client Portal | Student Dashboard | Student Portal |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/Lawyer portal.png" width="200"/> | <img src="assets/screenshots/Client Portal.png" width="200"/> | <img src="assets/screenshots/Student Dashboard.png" width="200"/> | <img src="assets/screenshots/Student Portal.png" width="200"/> |

### Student Learning & Tools
| Student Certification | Student Research | Student Profile |
|:---:|:---:|:---:|
| <img src="assets/screenshots/Student Certification Screen.png" width="200"/> | <img src="assets/screenshots/Student Research Screen.png" width="200"/> | <img src="assets/screenshots/Student Profile.png" width="200"/> |

### Core Application Features
| Search Screen | Chat Screen | Video Consultation | Profile Screen |
|:---:|:---:|:---:|:---:|
| <img src="assets/screenshots/Search Screen.png" width="200"/> | <img src="assets/screenshots/Chat Screen.png" width="200"/> | <img src="assets/screenshots/Video Screen.png" width="200"/> | <img src="assets/screenshots/Profile Screen.png" width="200"/> |

---

## 🏗️ Architecture

LexCore is architected with maintainability, scalability, and testability at its core. It strictly follows **Clean Architecture** principles and a **Feature-First** directory structure.

- **Feature-First Structure:** Every domain (e.g., Auth, Lawyer, Student, Chat) is isolated into its own module containing its specific presentation, domain, and data layers. This promotes unparalleled separation of concerns and allows teams to scale development without merge conflicts.
- **Presentation Layer:** Built with Flutter widgets and heavily utilizing `Riverpod` for reactive, unidirectional state management. UI components are kept dumb and only react to state emissions.
- **Domain Layer:** Contains pristine Dart code free of framework dependencies. It houses Entities, UseCases, and Repository Interfaces, representing the core business logic.
- **Data Layer:** Implements the repository interfaces. It manages data retrieval from Cloud Firestore, local caching via Hive, and API calls via Dio.
- **Dependency Injection:** Utilizes `get_it` combined with Riverpod's native provider scoping to construct and inject dependencies securely and efficiently.
- **Navigation:** Powered by `go_router` for robust, declarative routing, deep-linking, and seamless redirection logic based on authentication and role states.

---

## 📁 Project Structure

```text
lib/
├── app/                  # Application root, theme configurations, and routing setup
├── core/                 # Core utilities, constants (colors, typography), and errors
├── di/                   # Dependency injection setup (get_it configurations)
├── features/             # Feature-first modules
│   ├── ai_assistant/
│   ├── auth/
│   ├── chat/
│   ├── client/
│   ├── documents/
│   ├── lawyer/
│   ├── news/
│   ├── onboarding/
│   ├── payments/
│   ├── profile/
│   └── student/
├── services/             # Global services (Analytics, Notifications, Location)
└── shared/               # Reusable UI components (Buttons, Inputs, Dialogs)
```

---

## 🛠️ Tech Stack

LexCore relies on mature, industry-standard packages to deliver a flawless user experience.

| Technology | Purpose | Justification |
| :--- | :--- | :--- |
| **Flutter** | Frontend Framework | Enables compiling to high-performance native iOS and Android apps from a single codebase. |
| **Dart** | Programming Language | Highly optimized for UI development with strong typing and sound null safety. |
| **Firebase** | Backend as a Service | Provides robust Authentication, real-time Cloud Firestore, and seamless scalability. |
| **Riverpod** | State Management | Compile-safe, highly testable, and declarative state management. |
| **GoRouter** | Routing | Declarative routing supporting deep links, nesting, and complex redirection logic. |
| **Hive** | Local Database | Extremely fast, lightweight NoSQL local storage for caching and offline support. |
| **Dio & Http** | Networking | Powerful HTTP clients for REST API integrations and advanced interceptors. |
| **Flutter Map** | Geospatial Data | Lightweight, highly customizable map rendering without restrictive API keys. |
| **Get_It** | Dependency Injection | Service locator for decoupled architectural layers. |

---

## 🎨 Design System

LexCore implements a custom, highly cohesive design system built on top of Material 3 principles.

- **Typography:** Uses `Google Fonts` to provide clean, highly legible typography suited for dense legal information.
- **Colors:** A curated palette featuring deep slates (`#0F172A`), rich emeralds (`#10B981`) for success states, and vibrant blues (`#3B82F6`) for primary actions, establishing trust and authority.
- **Components:** Entirely bespoke widget library (`lex_button`, `lex_empty_state`, etc.) ensuring 100% visual consistency across all three portals.
- **Animations:** Strategic use of `flutter_animate` for micro-interactions and `lottie` for complex state illustrations, ensuring the application feels alive and responsive.

---

## 🔒 Security

Security is paramount in LegalTech. LexCore implements several layers of defense:

- **Authentication:** Token-based authentication utilizing Firebase Auth.
- **Role Separation:** Strict enforcement of RBAC at both the client routing layer and the database layer. A client cannot access lawyer dashboards, and vice versa.
- **Firestore Security Rules:** Granular read/write permissions ensuring users can only access their specific case data and communications.
- **Secure Storage:** Sensitive local data (e.g., session tokens, preferences) is encrypted.

---

## ⚡ Performance

The application is heavily optimized for 60/120 FPS rendering:

- **Constant Constructors:** Extensive use of `const` to prevent unnecessary widget rebuilds during state changes.
- **Lazy Loading:** `ListView.builder` and `Sliver` implementations ensure memory is conserved when displaying large lists of case files or lawyers.
- **Caching:** Network images are cached heavily via `cached_network_image`, and expensive Firestore queries are locally mirrored using `Hive`.
- **Targeted Rebuilds:** Riverpod's `select` and `ref.watch` are used meticulously to ensure only the exact UI components that require updates are rebuilt.

---

## 🚀 Installation & Setup

Follow these steps to run LexCore locally.

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.19.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Xcode (for iOS) & Android Studio (for Android)

### Clone the Repository
```bash
git clone https://github.com/yourusername/lex_core.git
cd lex_core
```

### Install Dependencies
```bash
flutter pub get
```

### Configuration
LexCore uses Firebase as its backend. Ensure you configure your environments properly:
1. Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
2. Register your Android and iOS applications.
3. Download `google-services.json` and place it in `android/app/`.
4. Download `GoogleService-Info.plist` and place it in `ios/Runner/`.

### Run the Application
```bash
flutter run
```

### Build for Production
**Android (App Bundle):**
```bash
flutter build appbundle --release
```
**iOS (IPA):**
```bash
flutter build ipa --release
```

---

## 💻 Usage

Upon launching LexCore, users are presented with a premium onboarding flow followed by a role selection gateway.

1. **Client Flow:** Select "Client", authenticate, and immediately begin searching for lawyers. Browse the interactive map, view lawyer profiles, and initiate a chat or video consultation.
2. **Lawyer Flow:** Select "Lawyer", authenticate, and enter the command center. Navigate the dashboard to manage pending hearings, review case files, and message clients.
3. **Student Flow:** Select "Student", authenticate, and access the learning portal. Track certification progress, read legal precedents, and participate in mock trials.

---

## 🎖️ Code Quality

This project is a testament to senior-level engineering standards:
- **SOLID Principles:** Strictly adhered to across all services and repositories.
- **DRY (Don't Repeat Yourself):** Highly modularized shared widgets and utility classes.
- **Separation of Concerns:** UI is completely decoupled from business logic and data fetching mechanisms.
- **Linting:** Enforces strict Dart linting rules via `flutter_lints` to guarantee code consistency and quality.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Senior Software Engineer**  
Passionate about architecting scalable solutions, clean code, and beautiful user interfaces.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/yourprofile)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/yourusername)
[![Portfolio](https://img.shields.io/badge/Portfolio-255E63?style=for-the-badge&logo=About.me&logoColor=white)](https://yourportfolio.com)
