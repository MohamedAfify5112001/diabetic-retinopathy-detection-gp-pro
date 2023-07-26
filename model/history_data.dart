import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String uId;
  final String patientName;
  final String stage;
  final String image;
  final int patientsAge;
  final String treatment;
  final String treatmentDuration;
  final String? drugs;
  final String timeOfConsultation;

  HistoryModel(
      {required this.uId,
      required this.patientName,
      required this.stage,
      required this.image,
      required this.patientsAge,
      required this.treatment,
      required this.treatmentDuration,
      required this.timeOfConsultation,
      this.drugs});

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
        uId: json['uId'],
        patientName: json['patientName'] as String,
        stage: json['stage'] as String,
        image: json['image'] as String,
        patientsAge: json['patientSAge'] as int,
        treatment: json['treatment'] as String,
        treatmentDuration: json['treatmentDuration'] as String,
        drugs: json['drugs'] == null ? "" : (json['drugs'] as String),
        timeOfConsultation: json['timeOfConsultation'] as String,
      );

  Map<String, dynamic> toMap() => {
        'patientName': patientName,
        'stage': stage,
        'image': image,
        'patientSAge': patientsAge,
        'treatment': treatment,
        'treatmentDuration': treatmentDuration,
        'drugs': drugs,
        'timeOfConsultation': timeOfConsultation
      };
}
