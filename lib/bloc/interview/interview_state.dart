part of 'interview_bloc.dart';

@immutable
sealed class InterviewState {}

final class InterviewInitial extends InterviewState {}

class ConfigInterview extends InterviewState {
  final String job;
  final String level;
  ConfigInterview(this.job, this.level);
}

class Unauthenticated extends InterviewState {}
