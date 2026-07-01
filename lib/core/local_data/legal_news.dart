// lib/core/local_data/legal_news.dart

class LegalNewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String category;
  final String source;
  final String publishedAt;
  final String readTime;
  final bool isBreaking;

  const LegalNewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.source,
    required this.publishedAt,
    required this.readTime,
    required this.isBreaking,
  });
}

class LegalNews {
  static const List<LegalNewsArticle> articles = [
    LegalNewsArticle(
      id: 'news_001',
      title: 'Supreme Court Issues Landmark Ruling on Digital Evidence Admissibility',
      summary: 'The Supreme Court of Pakistan has laid down comprehensive guidelines for the admissibility of digital evidence in criminal proceedings.',
      content:
          'In a landmark 5-member bench decision, the Supreme Court of Pakistan has established that digital evidence including WhatsApp messages, emails, and CCTV footage shall be admissible provided it meets authenticity standards under the Qanun-e-Shahadat Order. The court held that forensic certification is mandatory for all electronic records submitted in criminal cases. Justice Mansoor Ali Shah, writing for the majority, noted that Pakistan\'s legal framework must evolve to address modern evidentiary challenges. The judgment has been hailed as a watershed moment for cybercrime prosecution in the country.',
      category: 'Supreme Court',
      source: 'Dawn News',
      publishedAt: 'Jun 28, 2026',
      readTime: '4 min read',
      isBreaking: true,
    ),
    LegalNewsArticle(
      id: 'news_002',
      title: 'NAB Amendment Act: High Court Upholds Key Provisions',
      summary: 'The Lahore High Court has upheld major provisions of the 2022 NAB Amendment Act, dismissing challenges to accountability laws.',
      content:
          'The Lahore High Court\'s full bench has dismissed petitions challenging the constitutionality of the NAB Amendment Act 2022. The court ruled that parliament has the authority to define the scope of accountability institutions. The judgment stated that reducing the jurisdictional threshold of NAB to Rs. 500 million does not violate fundamental rights. Legal experts anticipate this ruling will face a challenge before the Supreme Court within weeks.',
      category: 'Constitutional',
      source: 'The News International',
      publishedAt: 'Jun 27, 2026',
      readTime: '3 min read',
      isBreaking: true,
    ),
    LegalNewsArticle(
      id: 'news_003',
      title: 'Federal Shariat Court Rules on Interest-Free Banking Timeline',
      summary: 'The Federal Shariat Court has given the government a five-year deadline to fully implement the Riba-free banking system.',
      content:
          'The Federal Shariat Court reaffirmed its landmark 2022 ruling and directed the government to eliminate all forms of Riba (interest) from Pakistan\'s financial system within five years. The court stated that interest-bearing transactions are repugnant to the injunctions of Islam. State Bank of Pakistan has been directed to submit quarterly progress reports. Major commercial banks are now consulting legal advisors to restructure their product offerings.',
      category: 'Constitutional',
      source: 'Business Recorder',
      publishedAt: 'Jun 26, 2026',
      readTime: '5 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_004',
      title: 'Punjab Tenancy Act Amendments Passed: New Rights for Tenants',
      summary: 'The Punjab Assembly has passed significant amendments to the Punjab Tenancy Act, strengthening tenant protections against arbitrary eviction.',
      content:
          'The Punjab Assembly has unanimously passed the Punjab Tenancy (Amendment) Act 2026, which requires landlords to provide a three-month written notice before eviction proceedings. The law also mandates that rent increases cannot exceed 10% annually. Tenants now have a statutory right to approach the Rent Controller without paying court fees. The Punjab Bar Association has welcomed the amendment, calling it a major step toward housing rights.',
      category: 'Property',
      source: 'Pakistan Today',
      publishedAt: 'Jun 25, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_005',
      title: 'Supreme Court Orders Speedy Trials in All Family Court Cases',
      summary: 'Chief Justice directs all family courts to decide pending cases within 6 months, tackling the massive backlog.',
      content:
          'The Chief Justice of Pakistan has issued a suo motu order directing all family courts to clear their backlog within six months. The order specifically targets cases of child custody, maintenance, and dissolution of marriage that have been pending for over two years. Family courts will now be required to hold hearings at least twice weekly per case. The Supreme Court has also ordered the Law Ministry to recruit 200 additional family court judges across the country.',
      category: 'Family',
      source: 'Geo News',
      publishedAt: 'Jun 24, 2026',
      readTime: '4 min read',
      isBreaking: true,
    ),
    LegalNewsArticle(
      id: 'news_006',
      title: 'Pakistan Bar Council Announces Reforms to Legal Education Standards',
      summary: 'PBC introduces new mandatory competency exams for fresh law graduates before enrollment as advocates.',
      content:
          'The Pakistan Bar Council has announced sweeping reforms to the legal education and enrollment framework. Starting January 2027, all new law graduates will be required to pass a two-part bar examination before being enrolled as advocates. The first part tests substantive law and the second tests practical court skills. The PBC chairman stated that these reforms aim to raise the quality of legal representation available to the public.',
      category: 'Constitutional',
      source: 'Legal Era Pakistan',
      publishedAt: 'Jun 23, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_007',
      title: 'Sindh High Court Strikes Down Section 499-A of PPC',
      summary: 'SHC rules that the aggravated form of criminal defamation introduced in 2024 violates the right to free speech.',
      content:
          'The Sindh High Court has declared Section 499-A of the Pakistan Penal Code unconstitutional, holding that the provision disproportionately curtails freedom of expression guaranteed under Article 19 of the Constitution. The bench noted that the provision had been used to silence journalists and political opponents. The federal government has been given 60 days to present its appeal before the Supreme Court. Press freedom groups have celebrated the ruling as a victory for democratic values.',
      category: 'Criminal',
      source: 'Dawn News',
      publishedAt: 'Jun 22, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_008',
      title: 'Property Transfer Tax Reduced to 1% in Federal Budget 2026-27',
      summary: 'The government has slashed property transfer taxes in a bid to formalize the real estate sector.',
      content:
          'Finance Minister announced in the federal budget that the capital value tax on property transfers will be reduced from 3% to 1% for the fiscal year 2026-27. The move is expected to encourage registration of previously undeclared real estate transactions. FBR has also launched a simplified online property transfer portal. Legal experts predict that this will significantly reduce under-the-table dealings in the property market.',
      category: 'Property',
      source: 'Business Recorder',
      publishedAt: 'Jun 21, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_009',
      title: 'Khula Cases Can Now Be Decided in 90 Days Under New Rules',
      summary: 'Family Court rules amended to fast-track khula proceedings, protecting women\'s right to dissolution of marriage.',
      content:
          'The Ministry of Law has notified new Family Court Rules that mandate khula applications be decided within 90 days. Judges who fail to meet the deadline must submit written explanations to the High Court. The reform follows years of advocacy by women\'s rights groups who noted that some khula cases dragged on for five years or more. Legal aid centers will now be established in every district to assist women who cannot afford legal representation.',
      category: 'Family',
      source: 'Express Tribune',
      publishedAt: 'Jun 20, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_010',
      title: 'Pakistan Signs Extradition Treaty with UAE',
      summary: 'A new bilateral extradition treaty with the UAE will allow Pakistan to seek return of financial fugitives.',
      content:
          'Pakistan and the UAE have signed a comprehensive bilateral extradition treaty that will facilitate the transfer of individuals facing criminal proceedings in either country. The treaty covers financial crimes, terrorism, and drug trafficking among other offenses. Legal experts note that several high-profile economic absconders currently residing in the UAE may now face extradition. The treaty must still be ratified by both parliaments before taking effect.',
      category: 'International',
      source: 'ARY News',
      publishedAt: 'Jun 19, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_011',
      title: 'Supreme Court Suo Motu on Overcrowded Prisons',
      summary: 'Chief Justice takes notice of severe overcrowding in Pakistani prisons, orders immediate remedial measures.',
      content:
          'The Supreme Court has taken suo motu notice of the critical overcrowding situation in Pakistan\'s prisons, where the actual population is reportedly 200% above capacity. The court has directed the Inspector General of Prisons of each province to submit a complete report within two weeks. The bench observed that inhumane prison conditions violate fundamental rights under Articles 9 and 14 of the Constitution. Sessions judges have been asked to expedite bail decisions for under-trial prisoners.',
      category: 'Criminal',
      source: 'The News International',
      publishedAt: 'Jun 18, 2026',
      readTime: '5 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_012',
      title: 'New Cybercrime Reporting Portal Launched by FIA',
      summary: 'FIA launches an online portal to streamline cybercrime complaints, reducing reporting time from weeks to hours.',
      content:
          'The Federal Investigation Agency has launched a digital cybercrime complaint portal at cybercrime.gov.pk, allowing citizens to report offences under PECA 2016 without physically visiting FIA offices. Citizens can submit evidence digitally and track their complaint status in real time. The portal also provides guidance on what constitutes an actionable cybercrime complaint. FIA Cyber Wing has expanded its workforce by 300 officers to handle the expected increase in reported cases.',
      category: 'Criminal',
      source: 'Samaa TV',
      publishedAt: 'Jun 17, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_013',
      title: 'Lahore High Court Expands Suo Motu Powers in Administrative Cases',
      summary: 'LHC rules that it can take cognizance of any public authority inaction without waiting for a formal petition.',
      content:
          'The Lahore High Court has issued a constitutional order clarifying that it may exercise suo motu jurisdiction over any case of government inaction that affects citizens\' fundamental rights. This ruling expands the court\'s supervisory role over administrative bodies. The judgment cites Article 199 of the Constitution as conferring broad remedial jurisdiction. Advocates have expressed concern that this could lead to a deluge of politically sensitive administrative cases.',
      category: 'Constitutional',
      source: 'Pakistan Today',
      publishedAt: 'Jun 16, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_014',
      title: 'Consumer Protection Council Recovers Rs. 2 Billion in Refunds',
      summary: 'The newly empowered Consumer Protection Council has secured over Rs. 2 billion in consumer refunds in its first year.',
      content:
          'The Pakistan Consumer Protection Council reported that it recovered Rs. 2.1 billion in refunds and compensation for consumers in its first full year of operations. The majority of successful complaints involved e-commerce fraud, defective electronics, and misleading real estate advertisements. The Council now has powers to impose fines of up to Rs. 25 million on violating businesses. Consumers can file complaints via the Council\'s mobile app or walk-in centers in all provincial capitals.',
      category: 'Constitutional',
      source: 'Profit Magazine',
      publishedAt: 'Jun 15, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_015',
      title: 'AJK Supreme Court Rules on Water Rights Dispute',
      summary: 'Azad Kashmir\'s apex court delivers judgment resolving a 15-year inter-district water rights dispute.',
      content:
          'The Supreme Court of Azad Jammu and Kashmir has resolved a landmark water rights dispute between Mirpur and Muzaffarabad districts that had been pending for 15 years. The court directed equitable distribution of water resources and established a joint water management committee comprising representatives from both districts. The judgment relies heavily on Islamic law principles of fair distribution of shared resources. Environmental experts have praised the ruling as a model for resolving water conflicts across Pakistan.',
      category: 'Supreme Court',
      source: 'AJK Tribune',
      publishedAt: 'Jun 14, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_016',
      title: 'FBR Issues New Guidelines on Inheritance Tax Documentation',
      summary: 'FBR clarifies documentation requirements for inheritance cases, easing the burden on legal heirs.',
      content:
          'The Federal Board of Revenue has issued a comprehensive circular clarifying the documentation requirements for transferring inherited property and financial assets. The new guidelines reduce the required documents from 14 to 7 for straightforward inheritance cases. Legal heirs are no longer required to obtain a succession certificate for movable property below Rs. 5 million. Tax practitioners have welcomed the circular as overdue simplification of a process that often took years.',
      category: 'Property',
      source: 'Business Recorder',
      publishedAt: 'Jun 13, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_017',
      title: 'Peshawar High Court Grants Historic Bail in Terrorism Case',
      summary: 'PHC grants bail to a suspect detained for over three years without charge, citing violation of Article 10-A.',
      content:
          'The Peshawar High Court has granted bail to a terrorism suspect who had been held for over 1,100 days without formal charge under the Anti-Terrorism Act. The bench ruled that indefinite detention without charges is a clear violation of Article 10-A which guarantees the right to a fair trial. The court observed that the prosecution had failed to present any substantive evidence before the court in three years. Human rights organizations have filed a separate constitutional petition seeking systemic reforms to ATA detention procedures.',
      category: 'Criminal',
      source: 'Dawn News',
      publishedAt: 'Jun 12, 2026',
      readTime: '5 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_018',
      title: 'E-Court System Expanded to All District Courts in Punjab',
      summary: 'Punjab government rolls out e-court technology to all 36 district courts, digitalizing case management.',
      content:
          'The Punjab government has announced the successful rollout of the E-Court Management System to all 36 district courts in the province. Lawyers can now file applications, track hearing schedules, and receive court orders electronically. The system also provides SMS alerts for hearing dates and procedural updates. The project, developed in partnership with the Supreme Court of Pakistan, is expected to reduce case pendency by 30% within two years.',
      category: 'Constitutional',
      source: 'The Express Tribune',
      publishedAt: 'Jun 11, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_019',
      title: 'Landmark Judgment: DNA Evidence Now Binding in Paternity Cases',
      summary: 'Supreme Court rules that DNA test results are conclusive evidence in paternity and child custody disputes.',
      content:
          'In a landmark ruling, the Supreme Court declared that DNA evidence is conclusive proof in matters of parentage and cannot be contradicted by presumptive evidence. The court directed all family courts to give primacy to DNA test results when the parentage of a child is disputed. Courts are now empowered to order DNA testing of any party in family proceedings. Legal scholars have noted that this decision aligns Pakistani family law with international standards while harmonizing with Islamic principles of nasab.',
      category: 'Family',
      source: 'Geo News',
      publishedAt: 'Jun 10, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_020',
      title: 'Sindh Assembly Passes Anti-Encroachment Law',
      summary: 'New law gives Sindh government sweeping powers to remove encroachments on public land within 30 days.',
      content:
          'The Sindh Assembly has passed the Sindh Public Land (Removal of Encroachments) Act 2026, which gives authorities the power to remove encroachments on government land without prior court order. Occupants have 30 days to vacate after receiving notice. The law includes an appellate mechanism before the Collector before eviction can be executed. Opposition parties have expressed concern that the law could be misused to settle political scores under the guise of anti-encroachment drives.',
      category: 'Property',
      source: 'The News International',
      publishedAt: 'Jun 09, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_021',
      title: 'Minimum Wage Enforcement: Labour Court Issues Rs. 50M Penalty',
      summary: 'A textile factory in Faisalabad has been fined Rs. 50 million for systematic minimum wage violations.',
      content:
          'A Labour Court in Faisalabad imposed a landmark Rs. 50 million penalty on a major textile company for failing to pay minimum wages to over 2,000 workers for a period of 18 months. The court also ordered immediate payment of all arrears with 10% compensation. The judgment sets a significant precedent for enforcement of minimum wage legislation under the Minimum Wages Ordinance. The factory\'s owners have filed an appeal before the Lahore High Court.',
      category: 'Constitutional',
      source: 'Pakistan Today',
      publishedAt: 'Jun 08, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_022',
      title: 'Pakistan Ratifies UNCAC Additional Protocol on Asset Recovery',
      summary: 'Pakistan formally ratifies an international protocol strengthening mechanisms for recovering looted state assets.',
      content:
          'Pakistan has formally ratified the Additional Protocol to the United Nations Convention Against Corruption, strengthening the legal framework for international asset recovery. The ratification allows Pakistan to make direct mutual legal assistance requests to signatory countries. Attorney General stated that at least \\\$2 billion in corruptly acquired assets could potentially be repatriated through this mechanism. Legal experts note that the framework must be supported by corresponding domestic legislation to be fully effective.',
      category: 'International',
      source: 'ARY News',
      publishedAt: 'Jun 07, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_023',
      title: 'High Court Orders Uniform Implementation of Rent Control Law',
      summary: 'Islamabad High Court directs all district rent controllers to follow a uniform rent assessment formula.',
      content:
          'The Islamabad High Court has directed all Rent Controllers in the federal capital to adopt a uniform rent assessment formula to prevent arbitrary rent fixation orders. The court found that different rent controllers were applying inconsistent standards that prejudiced both landlords and tenants. The judgment attaches a detailed schedule of permissible rent increase percentages based on property category and location. The order takes immediate effect and applies to all pending rent disputes.',
      category: 'Property',
      source: 'Islamabad Scene',
      publishedAt: 'Jun 06, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_024',
      title: 'Anti-Rape Crisis Cells Established in All Major Hospitals',
      summary: 'Following Supreme Court orders, anti-rape crisis cells are now operational in 45 hospitals across Pakistan.',
      content:
          'The federal government has confirmed that anti-rape crisis cells are now operational in 45 major hospitals across Pakistan, fulfilling a Supreme Court directive issued in 2025. Each cell is staffed by a medical officer, female police official, and social worker to provide immediate assistance to sexual assault survivors. Forensic evidence collection kits are available at all cells free of charge. The Anti-Rape Investigation and Trial Act requires that forensic examination be completed within 6 hours of the complaint.',
      category: 'Criminal',
      source: 'Samaa TV',
      publishedAt: 'Jun 05, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_025',
      title: 'Succession Certificate Process Digitized by Ministry of Law',
      summary: 'Online succession certificate applications launched, reducing wait time from 12 months to 45 days.',
      content:
          'The Ministry of Law has launched a fully digital succession certificate application process in partnership with NADRA and the provincial civil courts. Applicants can submit all documents online, track hearing dates, and receive certified copies digitally. The system cross-references NADRA databases to verify legal heirship. Previously, succession certificates took between six months and two years to obtain, often requiring multiple court hearings.',
      category: 'Property',
      source: 'The Express Tribune',
      publishedAt: 'Jun 04, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_026',
      title: 'Tax Tribunal Ruling: Non-Resident Pakistani Investment Properties Exempt',
      summary: 'Customs and Appellate Tribunal rules that overseas Pakistani property held for personal use is exempt from income tax.',
      content:
          'The Federal Tax Ombudsman and Customs Appellate Tribunal have jointly ruled that residential property owned by non-resident Pakistanis and used for personal or family use is not subject to deemed income tax provisions of the Finance Act. The ruling provides relief to millions of overseas Pakistanis who had been issued erroneous tax notices. FBR has been directed to withdraw all such notices within 30 days. The decision is expected to encourage further overseas Pakistani investment in domestic real estate.',
      category: 'Property',
      source: 'Business Recorder',
      publishedAt: 'Jun 03, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_027',
      title: 'Islamabad High Court Rules PECA Amendments Partially Unconstitutional',
      summary: 'IHC strikes down provisions allowing arrest without warrant under revised cybercrime law.',
      content:
          'The Islamabad High Court has partially struck down amendments to the Prevention of Electronic Crimes Act 2016, specifically the provision allowing warrantless arrest of suspected cybercriminals. The bench ruled that this provision violates Article 9 of the Constitution which protects personal liberty. The court ordered that all persons arrested under the invalidated provision be released within 48 hours unless rearrested under proper warrant. The ruling has been hailed by digital rights organizations as a landmark protection of civil liberties online.',
      category: 'Criminal',
      source: 'Dawn News',
      publishedAt: 'Jun 02, 2026',
      readTime: '5 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_028',
      title: 'Karachi Bar Association Elects New President in Historic Vote',
      summary: 'Advocate Sadia Hussain becomes first female president of the Karachi Bar Association in its 77-year history.',
      content:
          'The Karachi Bar Association has made history by electing Advocate Sadia Hussain as its first female president in 77 years of the organization\'s existence. Hussain won by a margin of 312 votes in a keenly contested election. She has pledged to modernize the bar\'s administrative systems and establish a dedicated legal aid desk for low-income litigants. Her election is seen as a milestone for women\'s participation in the legal profession in Sindh.',
      category: 'Constitutional',
      source: 'The News International',
      publishedAt: 'Jun 01, 2026',
      readTime: '3 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_029',
      title: 'Supreme Court Declares Benami Transactions Act Constitutional',
      summary: 'Apex court upholds the Benami Transactions (Prohibition) Act in a detailed judgment affirming state power to confiscate benami property.',
      content:
          'The Supreme Court has unanimously upheld the constitutionality of the Benami Transactions (Prohibition) Act 2017, rejecting arguments that it violated the right to property under Article 23. The court held that benami property is inherently tainted by illegality and thus unprotected by the constitutional guarantee. The judgment clarifies the evidentiary standard for proving benami ownership. Tax authorities have been empowered to use digital financial records and third-party data to establish benami arrangements.',
      category: 'Supreme Court',
      source: 'Geo News',
      publishedAt: 'May 30, 2026',
      readTime: '5 min read',
      isBreaking: false,
    ),
    LegalNewsArticle(
      id: 'news_030',
      title: 'International Court of Justice Accepts Pakistan\'s Maritime Case',
      summary: 'ICJ agrees to hear Pakistan\'s case against India regarding maritime boundary demarcation in the Arabian Sea.',
      content:
          'The International Court of Justice has formally accepted Pakistan\'s application to adjudicate the maritime boundary dispute with India in the Arabian Sea, including the contested Exclusive Economic Zone boundaries. Pakistan is represented by a team led by former Attorney General Anwar Mansoor Khan. The first preliminary hearings are scheduled for September 2026 in The Hague. A favorable ruling could give Pakistan access to significant offshore hydrocarbon and fishery resources.',
      category: 'International',
      source: 'ARY News',
      publishedAt: 'May 28, 2026',
      readTime: '4 min read',
      isBreaking: false,
    ),
  ];
}
