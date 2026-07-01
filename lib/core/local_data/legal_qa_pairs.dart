class LegalQAPair {
  final List<String> keywords;
  final String response;
  const LegalQAPair({required this.keywords, required this.response});
}

class LegalQA {
  static const String greetingResponse =
      'Assalam-o-Alaikum! Welcome to LexCore Legal Assistant. I am here to help you understand Pakistani law and legal procedures. You can ask me about bail, FIRs, property disputes, divorce, contracts, inheritance, or any other legal matter. How can I assist you today?';

  static const List<String> greetingKeywords = [
    'hello', 'hi', 'hey', 'salam', 'assalam', 'good morning', 'good afternoon', 'good evening'
  ];

  static const String defaultResponse =
      'That is an important legal question. Based on Pakistani law, I would recommend consulting with a qualified advocate who specialises in this area. Legal matters require careful consideration of the specific facts and applicable statutes. Could you provide more details about your situation so I can give you more targeted guidance?';

  static const List<LegalQAPair> pairs = [
    // === Criminal Law ===
    LegalQAPair(
      keywords: ['bail', 'arrested', 'arrest', 'police', 'custody', 'jail'],
      response: 'In Pakistan, bail is governed by the Code of Criminal Procedure (CrPC). For bailable offences, bail is a matter of right — the police must release you upon furnishing surety. For non-bailable offences, you must apply to a Sessions Court or High Court under Section 497 CrPC. The court considers flight risk, severity of offence, evidence strength, and previous record. I strongly recommend engaging a lawyer immediately upon arrest to protect your rights.',
    ),
    LegalQAPair(
      keywords: ['fir', 'first information report', 'police report', 'complaint', 'police station', 'thana'],
      response: 'An FIR (First Information Report) is the first step in criminal proceedings under Section 154 CrPC. Any person can lodge an FIR at the nearest police station. The SHO is legally bound to register it for cognizable offences. If the police refuse to register your FIR, you can approach the SP/SSP or file a complaint before the Magistrate under Section 22-A & 22-B CrPC. Always keep a copy of the FIR for your records.',
    ),
    LegalQAPair(
      keywords: ['murder', 'qatl', 'homicide', 'killing', 'death penalty'],
      response: 'Murder (Qatl-e-Amd) in Pakistan is governed by Sections 299-338 of the Pakistan Penal Code. The punishment can range from death to life imprisonment (25 years). Pakistan law allows Diyat (blood money) and Qisas (retribution) as alternatives under Islamic legal principles. A Compromise Deed (sulah) is possible in certain cases with the consent of the victim\'s heirs. Representation by an experienced criminal lawyer is essential.',
    ),
    LegalQAPair(
      keywords: ['theft', 'robbery', 'stolen', 'burglary', 'snatch', 'dacoity'],
      response: 'Theft is punishable under Section 379 PPC with up to 3 years imprisonment. Robbery (Section 392) carries up to 10 years. Dacoity (gang robbery) under Section 395 can attract up to life imprisonment. If you are a victim, file an FIR immediately and preserve any CCTV footage or witness information. If accused, seek legal counsel before making any statement to the police.',
    ),
    LegalQAPair(
      keywords: ['cybercrime', 'online fraud', 'hacking', 'blackmail', 'social media', 'harassment online'],
      response: 'Cybercrime in Pakistan is governed by the Prevention of Electronic Crimes Act (PECA) 2016. Offences include hacking (Section 3-4), identity theft (Section 16), cyber stalking (Section 24), and online harassment. Report to FIA Cybercrime Wing at helpline 9911 or visit their website. Preserve screenshots and digital evidence. Maximum punishment varies from 3 months to 14 years depending on the offence.',
    ),
    // === Property Law ===
    LegalQAPair(
      keywords: ['property', 'land', 'plot', 'house', 'real estate', 'registry', 'transfer'],
      response: 'Property transfer in Pakistan requires registration under the Registration Act 1908. Key documents include: Sale Deed (Bai Nama), Fard (revenue record), NOC from relevant authority, and CNIC copies. Always verify the title through a sub-registrar, check for any encumbrance or litigation, and ensure the property is not on evacuee or state land. A lawyer can conduct due diligence to protect your investment.',
    ),
    LegalQAPair(
      keywords: ['tenant', 'rent', 'landlord', 'eviction', 'lease', 'rental'],
      response: 'Tenant rights in Pakistan are governed by provincial Rent Restriction Acts. Key points: A landlord cannot evict without a court order. Rent increases are regulated (usually 10% annually). Tenants must be given proper notice (typically 15-30 days). Eviction grounds include non-payment of rent, subletting without permission, or personal need of the landlord. Always have a written tenancy agreement.',
    ),
    LegalQAPair(
      keywords: ['construction', 'building', 'illegal construction', 'building plan', 'noc'],
      response: 'Construction in Pakistan requires approval from the local development authority (LDA, CDA, KDA, etc.). You need an approved building plan, NOC from relevant authorities, and compliance with building bylaws. Unauthorised construction can result in demolition orders and penalties. Always obtain all permits before construction and retain a copy of the approved plans.',
    ),
    // === Family Law ===
    LegalQAPair(
      keywords: ['divorce', 'talaq', 'khula', 'separation', 'marriage end'],
      response: 'Divorce in Pakistan operates under Muslim Family Laws Ordinance 1961. A husband can pronounce Talaq by sending written notice to the Chairman of the Union Council and the wife. There is a 90-day reconciliation period. Khula is a wife\'s right to seek dissolution through the Family Court — she may return the Haq Mehr (dower). The process typically takes 3-6 months. Maintenance, child custody, and dowry articles are separate matters to be settled.',
    ),
    LegalQAPair(
      keywords: ['child custody', 'children', 'guardian', 'custody', 'hizanat'],
      response: 'Under Pakistani law (Guardians and Wards Act 1890), the welfare of the child is paramount. Generally, mothers have Hizanat (custody right) for sons up to age 7 and daughters until puberty, but courts can deviate based on the child\'s welfare. The father remains the natural guardian for property matters. Visitation rights are usually granted to the non-custodial parent. Courts consider the child\'s preference if they are old enough.',
    ),
    LegalQAPair(
      keywords: ['marriage', 'nikah', 'nikah nama', 'marriage registration', 'wedding'],
      response: 'Marriage (Nikah) in Pakistan must be registered under the Muslim Family Laws Ordinance 1961. The Nikah Nama (marriage contract) must specify the Haq Mehr (dower), maintenance terms, and conditions including the wife\'s right to divorce (if delegated). Registration is done through the Union Council. An unregistered marriage, while valid under Islamic law, may create difficulties in proving marital status for legal purposes.',
    ),
    LegalQAPair(
      keywords: ['domestic violence', 'abuse', 'wife beating', 'protection'],
      response: 'Domestic violence is a criminal offence in Pakistan. The Punjab Protection of Women Against Violence Act 2016 provides for protection orders, residence orders, and monetary relief. Victims can contact the Women Protection Authority helpline or file an FIR at the police station. The law also provides for electronic monitoring of abusers through GPS tracking in severe cases.',
    ),
    // === Inheritance & Succession ===
    LegalQAPair(
      keywords: ['inheritance', 'wirasat', 'succession', 'heir', 'will', 'estate'],
      response: 'Inheritance in Pakistan for Muslims is governed by Islamic law (Sharia). Key shares: Daughters receive half the share of sons. Wives get 1/8th if there are children, 1/4th if none. Mothers receive 1/6th if there are children. A Muslim can bequeath up to 1/3rd of the estate by will (Wasiyat). The Succession Certificate is obtained from a Civil Court to claim movable property and bank accounts of the deceased.',
    ),
    LegalQAPair(
      keywords: ['will', 'wasiyat', 'testament', 'bequest'],
      response: 'Under Islamic law applicable in Pakistan, a Muslim can make a Will (Wasiyat) for up to 1/3rd of their total estate. The remaining 2/3rds are distributed according to fixed Quranic shares. A Will must be attested by two witnesses. For non-Muslims, the Succession Act 1925 applies, allowing them to bequeath their entire estate by will. Probate is required for wills of non-Muslims in certain jurisdictions.',
    ),
    // === Contract & Business Law ===
    LegalQAPair(
      keywords: ['contract', 'agreement', 'breach', 'deal', 'business agreement'],
      response: 'Contracts in Pakistan are governed by the Contract Act 1872. A valid contract requires: offer, acceptance, consideration, free consent, competent parties, and lawful object. Breach of contract entitles the injured party to damages (Section 73), specific performance, or injunction. Written contracts are strongly recommended. Oral contracts are valid but difficult to prove. Always include dispute resolution clauses and jurisdiction.',
    ),
    LegalQAPair(
      keywords: ['company', 'business registration', 'startup', 'partnership', 'llc', 'secp'],
      response: 'Business registration in Pakistan is done through SECP (Securities & Exchange Commission). Options include: Sole Proprietorship (simplest), Partnership (registered under Partnership Act 1932), Private Limited Company (Section 2(47) Companies Act 2017), or Single Member Company. Private Limited requires minimum 2 directors and registered office. NTN registration with FBR is mandatory. Process takes 3-7 working days through SECP online portal.',
    ),
    // === Consumer Rights ===
    LegalQAPair(
      keywords: ['consumer', 'defective product', 'refund', 'warranty', 'consumer rights'],
      response: 'Consumer rights in Pakistan are protected under provincial Consumer Protection Acts. You can file a complaint with the Consumer Court for defective products, misleading advertisements, or unfair trade practices. The court can order refund, replacement, compensation, or punitive damages. Complaints can be filed directly without a lawyer. Keep all receipts, warranty cards, and correspondence as evidence.',
    ),
    // === Employment ===
    LegalQAPair(
      keywords: ['employment', 'job', 'fired', 'salary', 'termination', 'labour', 'worker'],
      response: 'Employment in Pakistan is governed by various labour laws. Key protections include: minimum wage (set by province), maximum 48-hour work week, right to social security (ESSI), and EOBI contributions. Wrongful termination can be challenged before the Labour Court. For industrial workers, the Industrial Relations Act 2012 provides for collective bargaining and trade unions. Always maintain your appointment letter and salary slips.',
    ),
    LegalQAPair(
      keywords: ['harassment', 'workplace harassment', 'sexual harassment'],
      response: 'Workplace harassment is governed by the Protection Against Harassment of Women at the Workplace Act 2010. Every organisation with more than 10 employees must establish an Inquiry Committee. Complaints can also be filed with the Federal or Provincial Ombudsperson. The Act covers both public and private sector employees. Punishment includes fines, termination, and blacklisting.',
    ),
    // === Constitutional & Human Rights ===
    LegalQAPair(
      keywords: ['fundamental rights', 'constitution', 'constitutional', 'basic rights', 'freedom'],
      response: 'Fundamental Rights in Pakistan are enshrined in Part II, Chapter 1 of the Constitution (Articles 8-28). These include: right to life and liberty (Art 9), dignity (Art 14), freedom of movement (Art 15), assembly (Art 16), association (Art 17), speech (Art 19), religion (Art 20), equality before law (Art 25), and right to education (Art 25A). Any violation can be challenged through a Constitutional Petition in the High Court under Article 199.',
    ),
    LegalQAPair(
      keywords: ['blasphemy', 'section 295', 'religious offence'],
      response: 'Blasphemy laws in Pakistan (Sections 295-298 PPC) are among the strictest globally. Section 295-C prescribes the death penalty or life imprisonment. These cases are extremely sensitive and require immediate legal representation. The accused should not make any statements without legal counsel. The Supreme Court has established procedural safeguards to prevent misuse, including requirement of thorough investigation before registration.',
    ),
    // === Immigration & Citizenship ===
    LegalQAPair(
      keywords: ['visa', 'passport', 'immigration', 'travel', 'overseas', 'abroad'],
      response: 'Pakistani passport and visa matters are handled by the Directorate General of Immigration & Passports. For visa issues, contact the relevant embassy. Exit Control List (ECL) restrictions can be challenged in court. Dual nationality is permitted with certain countries. NICOP/POC holders have specific rights regarding property ownership and banking in Pakistan. For overseas Pakistanis, the Ministry of Overseas Pakistanis provides assistance.',
    ),
    // === Tax ===
    LegalQAPair(
      keywords: ['tax', 'income tax', 'fbr', 'ntn', 'tax return'],
      response: 'Income tax in Pakistan is governed by the Income Tax Ordinance 2001. All individuals earning above the taxable threshold must file returns with FBR (Federal Board of Revenue). Filing deadline is typically September 30. Tax filers enjoy lower withholding rates. NTN (National Tax Number) registration is free through the FBR IRIS portal. Non-filing penalties include higher withholding, restriction on property purchase above Rs. 5 million, and inability to purchase vehicles above 1300cc.',
    ),
    // === Court Procedures ===
    LegalQAPair(
      keywords: ['court', 'hearing', 'judge', 'court procedure', 'court process'],
      response: 'Pakistani court hierarchy: Supreme Court → High Courts (Lahore, Sindh, Peshawar, Balochistan) → District & Sessions Courts → Civil/Magistrate Courts. Civil cases start with filing a plaint (suit). Criminal cases start with an FIR or private complaint. Court hearings are typically brief (10-30 minutes). Cases can take months to years depending on complexity. Always appear on the hearing date or send your lawyer with authorisation.',
    ),
    LegalQAPair(
      keywords: ['appeal', 'review', 'revision', 'challenge', 'higher court'],
      response: 'Appeals in Pakistan follow this hierarchy: Trial Court → District Court → High Court → Supreme Court. Appeals must be filed within 30 days of the judgment (for civil matters) or as specified. A revision petition can be filed for errors of jurisdiction. A review petition can be filed before the same court on grounds of discovery of new evidence or apparent error. Leave to appeal to the Supreme Court is granted under Article 185 of the Constitution.',
    ),
    LegalQAPair(
      keywords: ['evidence', 'proof', 'witness', 'testimony', 'document evidence'],
      response: 'The law of evidence in Pakistan is governed by the Qanun-e-Shahadat Order 1984. Key types of evidence: oral testimony, documentary evidence, electronic evidence (admissible under the Electronic Transactions Ordinance 2002), and circumstantial evidence. Witnesses can be compelled to appear through summons. Cross-examination is a fundamental right. The burden of proof lies on the party making the assertion. Always preserve original documents and maintain chain of custody for physical evidence.',
    ),
    // === Miscellaneous ===
    LegalQAPair(
      keywords: ['defamation', 'libel', 'slander', 'reputation'],
      response: 'Defamation in Pakistan can be both civil and criminal. Criminal defamation is punishable under Section 499 PPC with up to 2 years imprisonment. Civil defamation can result in monetary damages. Truth is a defence if the publication was for public good. Social media defamation is increasingly prosecuted under PECA. To file a defamation case, you need to prove the statement was made, it was defamatory, it referred to you, and it was published to third parties.',
    ),
    LegalQAPair(
      keywords: ['cheque bounce', 'dishonoured cheque', 'check', 'bounced cheque'],
      response: 'Dishonour of cheque in Pakistan is an offence under Section 489-F PPC, punishable with up to 3 years imprisonment or fine or both. The complainant must present the cheque within its validity period, receive a dishonour memo from the bank, send a legal notice giving 30 days to pay, and then file a complaint. The court may order payment of the cheque amount plus compensation.',
    ),
    LegalQAPair(
      keywords: ['nab', 'corruption', 'accountability', 'anti-corruption'],
      response: 'NAB (National Accountability Bureau) handles corruption cases under the National Accountability Ordinance 1999. NAB can investigate corruption exceeding Rs. 50 million (amended threshold). Voluntary Return is an option before formal proceedings. The conviction rate has historically varied. Legal representation is crucial as NAB has broad powers of arrest and asset freezing. Bail in NAB cases is generally difficult but not impossible.',
    ),
    LegalQAPair(
      keywords: ['land revenue', 'patwari', 'fard', 'mutation', 'intaqal'],
      response: 'Land revenue records in Pakistan are maintained by Patwaris (revenue officials). Key documents: Fard (ownership extract), Intiqal (mutation/transfer), Jamabandi (village record), Latha/Tatima (land map). Mutation must be done within 4 months of any transfer. Always verify records from the Tehsildar office. Digitalisation under the Punjab Land Record Authority (PLRA) has improved transparency. Disputes can be filed before the Revenue Court or Civil Court.',
    ),
    LegalQAPair(
      keywords: ['power of attorney', 'wakeel nama', 'proxy', 'authority'],
      response: 'A Power of Attorney (Wakeel Nama) in Pakistan authorises someone to act on your behalf. General Power of Attorney covers broad authority; Special Power of Attorney is for specific transactions. For property matters, it must be registered and attested before a Sub-Registrar. Overseas Pakistanis must get their Power of Attorney attested by the Pakistan Embassy/Consulate. It can be revoked at any time by the principal.',
    ),
  ];
}
