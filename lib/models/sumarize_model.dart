// import 'package:skintelligent/controllers/api/endpoint.dart';

// class SummarizeModel {
//   final List<SummaryItem> messages;
//   SummarizeModel({
//     required this.messages,
//   });
//   factory SummarizeModel.fromJson(Map<String, dynamic> json) {
//     return SummarizeModel(
//       messages: (json[ApiKey.summaryMessage] as List)
//           .map((e) => SummaryItem.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class SummaryItem {
//   final String role;
//   final String content;
//   SummaryItem({
//     required this.role,
//     required this.content,
//   });

//   factory SummaryItem.fromJson(Map<String, dynamic> json) {
//     return SummaryItem(
//       role: json[ApiKey.role],
//       content: json[ApiKey.content],
//     );
//   }
// }

class SummarizeModelResponse {
  final List<String> Patient_symptoms;
  final String Symptom_location;
  final String Duration;
  final String Symptom_progression;
  final String Risk_factors;
  SummarizeModelResponse({
    required this.Patient_symptoms,
    required this.Symptom_location,
    required this.Duration,
    required this.Symptom_progression,
    required this.Risk_factors,
  });

  factory SummarizeModelResponse.fromJson(Map<String, dynamic> json) {
    return SummarizeModelResponse(
      Patient_symptoms: List<String>.from(json['Patient_symptoms']),
      Symptom_location: json['Symptom_location'],
      Duration: json['Duration'],
      Symptom_progression: json['Symptom_progression'],
      Risk_factors: json['Risk_factors'],
    );
  }
}
