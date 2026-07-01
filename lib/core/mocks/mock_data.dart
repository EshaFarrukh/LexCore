class MockData {
  // === Student Mock Profile ===
  static const Map<String, dynamic> currentStudent = {
    'id': 'std_123',
    'name': 'Esha Farrukh',
    'role': 'Law Student',
    'university': 'Lahore Garrison University',
    'location': 'Lahore, Pakistan',
    'semester': 'Final Year',
    'email': 'esha.student@example.com',
    'avatarUrl': 'https://i.pravatar.cc/150?u=esha',
    'interests': [
      'Corporate Law',
      'Constitutional Law',
      'Legal Research',
      'Moot Court'
    ],
    'progress': 0.85,
  };

  // === Lawyer Mock Profiles ===
  static const List<Map<String, dynamic>> lawyers = [
    {
      'id': 'lw_1',
      'name': 'Ayesha Khan',
      'specialization': 'Family Law',
      'experience': '8 Years',
      'rating': 4.9,
      'reviews': 124,
      'fee': 'Rs. 5000',
      'location': 'Gulberg, Lahore',
      'languages': ['English', 'Urdu'],
      'avatarUrl': 'https://i.pravatar.cc/150?u=ayesha',
      'about': 'Ayesha Khan is a seasoned Family Law expert with over 8 years of experience in handling complex divorce, custody, and inheritance matters in Lahore courts.',
      'availability': 'Mon - Fri (10 AM - 4 PM)',
    },
    {
      'id': 'lw_2',
      'name': 'Ali Raza',
      'specialization': 'Corporate Law',
      'experience': '12 Years',
      'rating': 4.8,
      'reviews': 89,
      'fee': 'Rs. 8000',
      'location': 'DHA Lahore',
      'languages': ['English', 'Urdu', 'Punjabi'],
      'avatarUrl': 'https://i.pravatar.cc/150?u=ali',
      'about': 'Ali specializes in corporate registration, mergers, and business taxation. He has represented numerous startups across Punjab.',
      'availability': 'Tue - Thu (2 PM - 7 PM)',
    },
    {
      'id': 'lw_3',
      'name': 'Hamza Malik',
      'specialization': 'Property Law',
      'experience': '15 Years',
      'rating': 4.7,
      'reviews': 210,
      'fee': 'Rs. 6000',
      'location': 'Johar Town, Lahore',
      'languages': ['English', 'Urdu'],
      'avatarUrl': 'https://i.pravatar.cc/150?u=hamza',
      'about': 'Expert in property disputes, land registration, and real estate litigation with extensive practice at Lahore High Court.',
      'availability': 'Mon - Sat (9 AM - 5 PM)',
    },
    {
      'id': 'lw_4',
      'name': 'Fatima Noor',
      'specialization': 'Criminal Defense',
      'experience': '6 Years',
      'rating': 4.6,
      'reviews': 56,
      'fee': 'Rs. 7000',
      'location': 'District Court Lahore',
      'languages': ['English', 'Urdu'],
      'avatarUrl': 'https://i.pravatar.cc/150?u=fatima',
      'about': 'Fatima Noor is a passionate criminal defense attorney known for her aggressive representation at the Sessions Court Lahore.',
      'availability': 'On Call 24/7',
    },
  ];

  // === Client Mock Cases ===
  static const List<Map<String, dynamic>> activeCases = [
    {
      'id': 'case_1',
      'title': 'Property Dispute in DHA',
      'type': 'Property Law',
      'status': 'Active',
      'lawyer': 'Hamza Malik',
      'nextHearing': '24 Oct, 2026',
      'court': 'Sessions Court Lahore',
      'progress': 0.6,
      'timeline': [
        {'title': 'Case Created', 'date': '01 Sep, 2026', 'isCompleted': true},
        {'title': 'Lawyer Assigned', 'date': '05 Sep, 2026', 'isCompleted': true},
        {'title': 'Evidence Submitted', 'date': '20 Sep, 2026', 'isCompleted': true},
        {'title': 'Hearing Scheduled', 'date': '15 Oct, 2026', 'isCompleted': true},
        {'title': 'Court Appearance', 'date': '24 Oct, 2026', 'isCompleted': false},
        {'title': 'Judgment', 'date': 'Pending', 'isCompleted': false},
      ]
    },
    {
      'id': 'case_2',
      'title': 'Corporate Registration (Pvt) Ltd',
      'type': 'Corporate Law',
      'status': 'Pending Review',
      'lawyer': 'Ali Raza',
      'nextHearing': 'No Hearing',
      'court': 'SECP Lahore',
      'progress': 0.3,
      'timeline': [
        {'title': 'Documents Submitted', 'date': '10 Oct, 2026', 'isCompleted': true},
        {'title': 'Fee Paid', 'date': '12 Oct, 2026', 'isCompleted': true},
        {'title': 'Pending Review', 'date': 'Current Phase', 'isCompleted': false},
        {'title': 'Certificate Issued', 'date': 'Pending', 'isCompleted': false},
      ]
    },
    {
      'id': 'case_3',
      'title': 'Family Court Matter - Gulberg',
      'type': 'Family Law',
      'status': 'Hearing Scheduled',
      'lawyer': 'Ayesha Khan',
      'nextHearing': '30 Oct, 2026',
      'court': 'District Court Lahore',
      'progress': 0.4,
      'timeline': [
        {'title': 'Petition Filed', 'date': '01 Oct, 2026', 'isCompleted': true},
        {'title': 'Notice Issued', 'date': '15 Oct, 2026', 'isCompleted': true},
        {'title': 'First Hearing', 'date': '30 Oct, 2026', 'isCompleted': false},
        {'title': 'Mediation', 'date': 'Pending', 'isCompleted': false},
      ]
    }
  ];
}
