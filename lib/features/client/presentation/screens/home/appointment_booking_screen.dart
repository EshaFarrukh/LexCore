import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final String lawyerId;
  const AppointmentBookingScreen({super.key, required this.lawyerId});

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String? _selectedTime;
  String _mode = 'Video Call';

  final List<String> _timeSlots = [
    '09:00 AM', '10:00 AM', '11:30 AM', '02:00 PM', '04:00 PM', '05:30 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgDeep,
        title: Text('Book Appointment', style: AppTypography.h2),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kTextPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar
            Text('Select Date', style: AppTypography.h3),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.kBgSurface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.kBorder),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 90)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                    _selectedTime = null; // reset time on day change
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(color: AppColors.kBgElevated, shape: BoxShape.circle),
                  todayTextStyle: AppTypography.body.copyWith(color: AppColors.kTextPrimary, fontWeight: FontWeight.w600),
                  selectedDecoration: const BoxDecoration(color: AppColors.kSurfaceInverted, shape: BoxShape.circle),
                  selectedTextStyle: AppTypography.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  defaultTextStyle: AppTypography.body,
                  weekendTextStyle: AppTypography.body.copyWith(color: AppColors.kTextSecondary),
                  outsideTextStyle: AppTypography.body.copyWith(color: AppColors.kTextTertiary),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: AppTypography.h3,
                  leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.kTextPrimary),
                  rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.kTextPrimary),
                ),
              ),
            ).animate().fadeIn().slideY(begin: 0.1),
            const SizedBox(height: 32),

            // Time Slots
            Text('Available Slots', style: AppTypography.h3),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: _timeSlots.map((time) {
                final selected = _selectedTime == time;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = time),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 72) / 3, // adjusted for padding (24 * 2 + 12 * 2 = 72)
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.kSurfaceInverted : AppColors.kBgSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: selected ? AppColors.kSurfaceInverted : AppColors.kBorder),
                      boxShadow: selected ? [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
                      ] : null,
                    ),
                    child: Center(
                      child: Text(time, style: AppTypography.button.copyWith(
                        color: selected ? Colors.white : AppColors.kTextPrimary,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
            const SizedBox(height: 32),

            // Mode
            Text('Consultation Mode', style: AppTypography.h3),
            const SizedBox(height: 16),
            Row(
              children: [
                _modeCard('Video Call', Icons.videocam_rounded),
                const SizedBox(width: 16),
                _modeCard('In Person', Icons.storefront_rounded),
              ],
            ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
            
            const SizedBox(height: 48),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface,
          border: const Border(top: BorderSide(color: AppColors.kBorder)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24, offset: const Offset(0, -8)),
          ],
        ),
        child: LexButton(
          label: 'Proceed to Payment',
          style: LexButtonStyle.primary,
          fullWidth: true,
          onPressed: _selectedTime == null ? null : () {
            context.push(RouteNames.appointmentConfirmedScreen);
          },
        ),
      ),
    );
  }

  Widget _modeCard(String label, IconData icon) {
    final selected = _mode == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _mode = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: selected ? AppColors.kSurfaceInverted : AppColors.kBgSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? AppColors.kSurfaceInverted : AppColors.kBorder),
            boxShadow: selected ? [
              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
            ] : null,
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? Colors.white : AppColors.kTextSecondary, size: 28),
              const SizedBox(height: 12),
              Text(label, style: AppTypography.button.copyWith(
                color: selected ? Colors.white : AppColors.kTextPrimary,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
