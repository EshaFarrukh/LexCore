import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isConnecting = true;
  bool _isMuted = false;
  bool _isCameraOff = false;
  bool _isSpeakerOn = true;
  int _secondsElapsed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isConnecting = false);
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) setState(() => _secondsElapsed++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _endCall() {
    _timer?.cancel();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Call ended. Duration: $_formattedTime',
            style: GoogleFonts.plusJakartaSans()),
        backgroundColor: AppColors.kBgElevated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnecting) return _buildConnecting();
    return _buildCallUI();
  }

  Widget _buildConnecting() {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.kBrandGradient,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.videocam_rounded, color: Colors.white, size: 48),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(end: 1.1, duration: 800.ms),
            const SizedBox(height: 32),
            Text('Connecting...',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 8),
            Text('Establishing secure connection',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: AppColors.kTextSecondary)),
            const SizedBox(height: 32),
            SizedBox(
              width: 160,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.kBorder,
                valueColor: const AlwaysStoppedAnimation(AppColors.kBrand),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallUI() {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: Stack(
        children: [
          // "Remote video" — mock gradient with avatar
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 64),
                  ),
                  const SizedBox(height: 16),
                  Text('Adv. Raza Khan',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                  const SizedBox(height: 4),
                  Text('Criminal Law Specialist',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 13, color: AppColors.kTextSecondary)),
                ],
              ),
            ),
          ),

          // Encrypted badge
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.kSuccess.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.kSuccess.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_rounded, color: AppColors.kSuccess, size: 14),
                    const SizedBox(width: 6),
                    Text('Encrypted & Secure',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 11, color: AppColors.kSuccess, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 500.ms),
          ),

          // Duration timer
          Positioned(
            top: MediaQuery.of(context).padding.top + 48,
            left: 0,
            right: 0,
            child: Center(
              child: Text(_formattedTime,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16, color: AppColors.kTextSecondary, fontWeight: FontWeight.w600)),
            ),
          ),

          // "Local camera" PiP in corner
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            right: 16,
            child: Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                gradient: _isCameraOff
                    ? null
                    : const LinearGradient(
                        colors: [Color(0xFF2d2d44), Color(0xFF1C2128)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: _isCameraOff ? AppColors.kBgElevated : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.kBorder, width: 2),
              ),
              child: Center(
                child: _isCameraOff
                    ? const Icon(Icons.videocam_off_rounded, color: AppColors.kTextSecondary, size: 28)
                    : const Icon(Icons.person_rounded, color: AppColors.kTextSecondary, size: 36),
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _controlBtn(
                  _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                  _isMuted ? 'Unmute' : 'Mute',
                  AppColors.kBgElevated,
                  () => setState(() => _isMuted = !_isMuted),
                ),
                const SizedBox(width: 16),
                _controlBtn(
                  _isCameraOff ? Icons.videocam_off_rounded : Icons.videocam_rounded,
                  _isCameraOff ? 'Camera On' : 'Camera Off',
                  AppColors.kBgElevated,
                  () => setState(() => _isCameraOff = !_isCameraOff),
                ),
                const SizedBox(width: 16),
                _controlBtn(
                  _isSpeakerOn ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                  _isSpeakerOn ? 'Speaker' : 'Earpiece',
                  AppColors.kBgElevated,
                  () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                ),
                const SizedBox(width: 16),
                // End call
                GestureDetector(
                  onTap: _endCall,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.kError,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(Icons.call_end_rounded, color: Colors.white, size: 28),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _controlBtn(IconData icon, String label, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Icon(icon, color: AppColors.kTextPrimary, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, color: AppColors.kTextSecondary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
