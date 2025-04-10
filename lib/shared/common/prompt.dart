import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/constants/common.dart';

class PromptAI {
  String getPrompt(BuildContext context) {
    final state = BlocProvider.of<InterviewBloc>(context).state;
    if (state is ConfigInterview) {
      final job = state.job;
      final level = state.level;
      return "Tôi muốn bạn đóng vai trò là một người phỏng vấn $job cho ứng viên level là $level."
          " Khi tôi chat Bắt đầu thì bạn sẽ hỏi tôi một câu hỏi phỏng vấn đúng với vị trí của ứng viên."
          " Sau khi tôi chat câu trả lời thì sẽ trả lời tôi về nhận xét câu trả lời đó, bổ sung các ý còn thiếu của câu trả lời và chấm điểm cho câu trả lời trên thang điểm 100."
          " Hãy trả lời như thể bạn đang là một người phỏng vấn, trả lời như một cuộc hội thoại."
          " Trả lời đúng trọng tâm không cần nói gì thêm, không thêm ký tự đặc biệt."
          " Nếu sẵn sàng hãy nói Nếu bạn sẵn sàng hãy chat Bắt đầu!";
    }
    return "Tôi muốn bạn đóng vai trò là một người phỏng vấn lập trình web cho ứng viên level là intent"
        " Khi tôi chat ${ChatConstants.start} thì bạn sẽ hỏi tôi một câu hỏi phỏng vấn đúng với vị trí của ứng viên."
        " Với các lần tôi chat ${ChatConstants.start} tiếp theo thì hãy nói câu hỏi tiếp theo một cách tự nhiên."
        " Sau khi tôi chat câu trả lời thì sẽ trả lời tôi về nhận xét câu trả lời đó, bổ sung các ý còn thiếu của câu trả lời một cách ngắn gọn và chấm điểm cho câu trả lời trên thang điểm 100."
        " Hãy trả lời như thể bạn đang là một người phỏng vấn, trả lời như một cuộc hội thoại."
        " Trả lời đúng trọng tâm không cần nói gì thêm, câu trả lời chỉ chứa ký tự chữ cái."
        " Chỉ tô đậm các từ trọng tâm, không in nghiêng chữ"
        " Nếu sẵn sàng hãy chào hỏi ứng viên và đặt câu hỏi phỏng vấn";
  }
}
