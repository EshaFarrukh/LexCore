import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  double _selectedAmount = 1000;
  bool _isProcessing = false;
  final _amounts = [500.0, 1000.0, 2500.0, 5000.0];

  @override
  void dispose() {
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    if (_cardController.text.length < 16 || _expiryController.text.length < 4 || _cvvController.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all card details')),
      );
      return;
    }

    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    final success = Random().nextDouble() > 0.10;
    final txnId = 'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5).toUpperCase()}';

    setState(() => _isProcessing = false);

    if (!mounted) return;

    if (success) {
      _showSuccessSheet(txnId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Card declined. Please try again.', style: GoogleFonts.plusJakartaSans()),
          backgroundColor: AppColors.kError,
        ),
      );
    }
  }

  void _showSuccessSheet(String txnId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.kBgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: AppColors.kSuccessGradient,
                borderRadius: BorderRadius.circular(36),
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
            ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 20),
            Text('Donation Successful!',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)),
            const SizedBox(height: 8),
            Text('Thank you for supporting legal aid',
                style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.kTextSecondary)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.kBgElevated,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: Column(
                children: [
                  _receiptRow('Amount', 'Rs. ${_selectedAmount.toStringAsFixed(0)}'),
                  const Divider(color: AppColors.kBorder, height: 20),
                  _receiptRow('Transaction ID', txnId),
                  const Divider(color: AppColors.kBorder, height: 20),
                  _receiptRow('Date', _formatDate(DateTime.now())),
                  const Divider(color: AppColors.kBorder, height: 20),
                  _receiptRow('Status', 'Completed'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kBrand,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('Done', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _receiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary)),
        Text(value,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.kTextPrimary)),
      ],
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Support Legal Aid', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Demo badge
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.kWarning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kWarning.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: AppColors.kWarning, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Portfolio Demo — No real charges will be made.',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12, color: AppColors.kWarning, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 24),

            // Amount selection
            Text('Select Amount',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 12),
            Row(
              children: _amounts.map((amt) {
                final isSelected = _selectedAmount == amt;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedAmount = amt),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.kBrandGradient : null,
                        color: isSelected ? null : AppColors.kBgElevated,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? null : Border.all(color: AppColors.kBorder),
                      ),
                      child: Center(
                        child: Text('Rs.${amt.toInt()}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : AppColors.kTextSecondary,
                            )),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 28),

            // Card details
            Text('Card Details',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 12),
            _buildField(_cardController, 'Card Number', Icons.credit_card_rounded, '4242 4242 4242 4242',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildField(_expiryController, 'Expiry', Icons.calendar_today_rounded, 'MM/YY',
                      inputFormatters: [LengthLimitingTextInputFormatter(5)]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(_cvvController, 'CVV', Icons.lock_rounded, '123',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                      obscure: true),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildField(_nameController, 'Cardholder Name', Icons.person_rounded, 'Full Name'),
            const SizedBox(height: 32),

            // Pay button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.kBrandGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : Text('Donate Rs. ${_selectedAmount.toInt()}',
                          style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon, String hint,
      {List<TextInputFormatter>? inputFormatters, bool obscure = false}) {
    return TextField(
      controller: ctrl,
      obscureText: obscure,
      inputFormatters: inputFormatters,
      style: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary, fontSize: 13),
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextTertiary, fontSize: 13),
        prefixIcon: Icon(icon, color: AppColors.kBrand, size: 20),
        filled: true,
        fillColor: AppColors.kBgElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.kBrand, width: 2),
        ),
      ),
    );
  }
}
