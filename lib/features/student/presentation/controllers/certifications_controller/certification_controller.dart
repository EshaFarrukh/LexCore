import 'dart:developer';

import 'package:flutter_riverpod/legacy.dart';
import 'package:lex_core/di/injection_container.dart';
import 'package:lex_core/features/student/data/models/certification_model.dart';
import 'package:lex_core/features/student/domain/usecases/student_usecases.dart';
import 'package:lex_core/features/student/presentation/states/certification_states.dart';

class CertificationController extends StateNotifier<CertificationStates> {
  final GetCertificationsUseCase _getCertificationsUseCase;

  CertificationController({GetCertificationsUseCase? getCertificationsUseCase})
      : _getCertificationsUseCase = getCertificationsUseCase ?? sl<GetCertificationsUseCase>(),
        super(CertificationInitialState());

  Future<void> getAllCertifications() async {
    state = CertificationLoadingState();
    try {
      final certifications = await _getCertificationsUseCase.execute();

      final completedList = certifications.where((c) => c.isCompleted).toList();
      final availableList = certifications.where((c) => !c.isCompleted).toList();

      final allCertifications = AllCertificationsResponse(
        completedCertifications: completedList,
        availableCertifications: availableList,
      );

      state = CertificationSuccessState(data: allCertifications);
    } catch (e, stack) {
      log('Get All Certifications -> Error: $e\n$stack');
      state = CertificationFailureState(error: 'Unable to load certifications data');
    }
  }

  Future<void> enrollInCertification(String certificationId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (state is CertificationSuccessState) {
        final currentData = (state as CertificationSuccessState).data;
        final completedCertifications = List<CertificationModel>.from(currentData.completedCertifications);
        final availableCertifications = List<CertificationModel>.from(currentData.availableCertifications);

        final certificationToEnroll = availableCertifications.firstWhere(
          (certification) => certification.id == certificationId,
          orElse: () => throw Exception('Certification not found'),
        );

        // Move certification from available to completed (simulating enrollment completion)
        final enrolledCertification = CertificationModel(
          id: certificationToEnroll.id,
          title: certificationToEnroll.title,
          description: certificationToEnroll.description,
          startDate: certificationToEnroll.startDate,
          endDate: certificationToEnroll.endDate,
          certificateImage: certificationToEnroll.certificateImage,
          isCompleted: true,
          duration: certificationToEnroll.duration,
          instructor: certificationToEnroll.instructor,
          level: certificationToEnroll.level,
          skills: certificationToEnroll.skills,
        );

        availableCertifications.removeWhere((certification) => certification.id == certificationId);
        completedCertifications.add(enrolledCertification);

        final updatedData = AllCertificationsResponse(
          completedCertifications: completedCertifications,
          availableCertifications: availableCertifications,
        );

        state = CertificationSuccessState(data: updatedData);
      }
    } catch (e, stack) {
      log('Enroll in Certification â†’ Error: $e\n$stack');
      state = CertificationFailureState(error: 'Failed to enroll in certification');
    }
  }

  Future<void> refreshCertifications() async {
    await getAllCertifications();
  }
}

