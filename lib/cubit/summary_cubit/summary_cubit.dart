import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/summary_cubit/summary_state.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';

class SummaryCubit extends Cubit<SummaryState> {
  final UserRepository userRepository;

  SummaryCubit(this.userRepository) : super(SummaryInitial());

  Future<void> getSummary(List<Map<String, String>> messages) async {
    emit(SummaryLoading());

    final result = await userRepository.summarize(messages);

    result.fold((failure) => emit(SummaryFailure(failure)),
        (summaryResponse) => emit(SummarySuccess(summaryResponse)));
  }
}
