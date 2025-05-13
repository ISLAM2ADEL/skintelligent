import 'package:skintelligent/models/sumarize_model.dart';

abstract class SummaryState {}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummarySuccess extends SummaryState {
  final SummarizeModelResponse summary;

  SummarySuccess(this.summary);
}

class SummaryFailure extends SummaryState {
  final String errMessage;

  SummaryFailure(this.errMessage);
}
