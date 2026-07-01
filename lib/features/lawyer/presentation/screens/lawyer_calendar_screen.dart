import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class _HearingEvent {
  final String caseNo;
  final String title;
  final String time;
  final String courtRoom;
  final String clientName;

  const _HearingEvent({
    required this.caseNo,
    required this.title,
    required this.time,
    required this.courtRoom,
    required this.clientName,
  });
}

class LawyerCalendarScreen extends StatefulWidget {
  const LawyerCalendarScreen({super.key});

  @override
  State<LawyerCalendarScreen> createState() => _LawyerCalendarScreenState();
}

class _LawyerCalendarScreenState extends State<LawyerCalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<_HearingEvent>> _events;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _events = _generateMockEvents();
  }

  Map<DateTime, List<_HearingEvent>> _generateMockEvents() {
    final now = DateTime.now();
    final map = <DateTime, List<_HearingEvent>>{};

    void add(int dayOffset, _HearingEvent event) {
      final d = DateTime(now.year, now.month, now.day + dayOffset);
      map.putIfAbsent(d, () => []).add(event);
    }

    add(1, const _HearingEvent(caseNo: '2024-CR-001', title: 'State vs. Ahmed Khan', time: '10:00 AM', courtRoom: 'Court Room 3', clientName: 'Ahmed Khan'));
    add(1, const _HearingEvent(caseNo: '2024-CV-023', title: 'Property Dispute - Raza', time: '2:00 PM', courtRoom: 'Court Room 7', clientName: 'Raza Malik'));
    add(3, const _HearingEvent(caseNo: '2024-FM-045', title: 'Divorce Proceedings', time: '11:30 AM', courtRoom: 'Family Court 2', clientName: 'Nadia Ali'));
    add(5, const _HearingEvent(caseNo: '2024-CR-067', title: 'Bail Application', time: '9:00 AM', courtRoom: 'Court Room 1', clientName: 'Tariq Hussain'));
    add(7, const _HearingEvent(caseNo: '2024-PT-012', title: 'Commercial Transfer', time: '3:00 PM', courtRoom: 'Court Room 5', clientName: 'Usman Corp'));
    add(10, const _HearingEvent(caseNo: '2024-CV-089', title: 'Contract Dispute', time: '10:30 AM', courtRoom: 'Court Room 4', clientName: 'Tech Corp Ltd'));
    add(14, const _HearingEvent(caseNo: '2024-FM-034', title: 'Child Custody Hearing', time: '12:00 PM', courtRoom: 'Family Court 1', clientName: 'Farooq Family'));
    add(-2, const _HearingEvent(caseNo: '2024-CR-102', title: 'Theft Case', time: '10:00 AM', courtRoom: 'Court Room 6', clientName: 'Imran Sheikh'));
    add(-5, const _HearingEvent(caseNo: '2024-PT-099', title: 'Land Mutation Dispute', time: '11:00 AM', courtRoom: 'Revenue Court', clientName: 'Shahid Mehmood'));

    return map;
  }

  List<_HearingEvent> _getEventsForDay(DateTime day) {
    final normalised = DateTime(day.year, day.month, day.day);
    return _events[normalised] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _getEventsForDay(_selectedDay);

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Hearing Calendar', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.kBgSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: TableCalendar(
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGold, width: 2),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: GoogleFonts.plusJakartaSans(color: AppColors.kGold, fontWeight: FontWeight.w600),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.kBrand,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w700),
                defaultTextStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 13),
                weekendTextStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary, fontSize: 13),
                outsideTextStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 13),
                markerDecoration: const BoxDecoration(
                  color: AppColors.kBrand,
                  shape: BoxShape.circle,
                ),
                markerSize: 5,
                markersMaxCount: 2,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary),
                leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.kBrand),
                rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.kBrand),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.kTextSecondary),
                weekendStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.kTextTertiary),
              ),
            ),
          ),

          // Selected day events
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  selectedEvents.isEmpty ? 'No hearings scheduled' : '${selectedEvents.length} hearing${selectedEvents.length > 1 ? "s" : ""}',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.kTextSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: selectedEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_available_rounded, size: 48, color: AppColors.kTextTertiary),
                        const SizedBox(height: 12),
                        Text('No hearings on this date',
                            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.kTextSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, i) {
                      final event = selectedEvents[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.kBgSurface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.kBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.kBrand.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(event.caseNo,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.kBrand)),
                                ),
                                const Spacer(),
                                Icon(Icons.access_time_rounded, size: 14, color: AppColors.kGold),
                                const SizedBox(width: 4),
                                Text(event.time,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.kGold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(event.title,
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                            const SizedBox(height: 4),
                            Text('${event.courtRoom} · Client: ${event.clientName}',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, color: AppColors.kTextSecondary)),
                          ],
                        ),
                      ).animate(delay: (i * 80).ms).fadeIn(duration: 300.ms).slideX(begin: 0.05);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Schedule hearing feature coming soon',
                  style: GoogleFonts.plusJakartaSans()),
              backgroundColor: AppColors.kBgElevated,
            ),
          );
        },
        backgroundColor: AppColors.kBrand,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Schedule', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: Colors.white)),
      ),
    );
  }
}
