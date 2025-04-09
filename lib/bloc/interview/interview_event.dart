part of 'interview_bloc.dart';

@immutable
sealed class InterviewEvent {}

class ConfigSuccess extends InterviewEvent {
  final String job;
  final String level;
  ConfigSuccess(this.job, this.level);
}

class RemoveConfig extends InterviewEvent {}
