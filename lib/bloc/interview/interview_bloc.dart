import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'interview_event.dart';
part 'interview_state.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  InterviewBloc() : super(InterviewInitial()) {
    on<ConfigSuccess>(_onConfigInterview);
  }

  void _onConfigInterview(ConfigSuccess event, Emitter<InterviewState> emit) {
    emit(ConfigInterview(event.job, event.level));
  }
}
