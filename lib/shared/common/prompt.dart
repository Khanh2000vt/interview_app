import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';

class PromptAI {
  String getPrompt(BuildContext context) {
    final state = BlocProvider.of<InterviewBloc>(context).state;
    if (state is ConfigInterview) {
      final job = state.job;
      final level = state.level;
      return 'Hãy tưởng tượng bạn là một người phỏng vấn $job cho ứng viên level là $level. Khi tôi chat Bắt đầu thì bạn sẽ hỏi tôi một câu hỏi phỏng vấn đúng với vị trí của ứng viên. Sau khi tôi chat câu trả lời thì sẽ trả lời tôi về nhận xét câu trả lời đó và chấm điểm cho câu trả lời trên thang điểm 100. Trả lời đúng trọng tâm không cần nói gì thêm, không thêm ký tự đặc biệt. Nếu sẵn sàng hãy nói "Nếu bạn sẵn sàng hãy chat Bắt đầu!"';
    }
    return '';
  }
}
