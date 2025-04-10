import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:interview_app/atomic/atoms/button/button_app.dart';
import 'package:interview_app/atomic/atoms/button/button_app_model.dart';
import 'package:interview_app/atomic/atoms/text/text_app.dart';
import 'package:interview_app/atomic/organisms/form-field/form_app.dart';
import 'package:interview_app/atomic/organisms/form-field/form_app_model.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/services/gemini.dart';
import 'package:interview_app/shared/chat/chat_message.dart';
import 'package:interview_app/shared/common/prompt.dart';
import 'package:interview_app/themes/scale.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final GeminiApiClient apiClient = GeminiApiClient();
  final List<ChatMessage> messages = [];

  String question = '';
  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final prompt = PromptAI().getPrompt(context);
    handleGemini(prompt);
  }

  void _sendMessage() {
    if ((formKey.currentState?.saveAndValidate() ?? false) == false) {
      return;
    }
    final message = formKey.currentState?.fields['answer']?.value as String?;
    if (message == null || message.isEmpty) return;
    handleGemini(message);
  }

  Future<void> handleGemini(String answer) async {
    // try {
    //   setState(() {
    //     loading = true;
    //   });
    //   messages.add(ChatMessage(role: 'user', content: answer));
    //   final response = await apiClient.sendMessage(messages, answer);
    //   messages.add(ChatMessage(role: 'model', content: response));
    //   setState(() {
    //     question = response;
    //   });
    //   _clearForm();
    // } catch (e) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text('Error: $e')));
    // } finally {
    //   setState(() {
    //     loading = false;
    //   });
    // }
  }

  void _clearForm() {
    formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phỏng vấn'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<InterviewBloc>().add(RemoveConfig());
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child:
                      loading
                          ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextApp(question, fontSize: 14),
                          ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: scaleH(20),
                children: [
                  FormApp(
                    FormAppModel([
                      InputFieldModel(
                        name: 'answer',
                        labelText: 'Câu trả lời',
                        enabled: !loading,
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập',
                          ),
                        ],
                      ),
                    ]),
                    formKey: formKey,
                  ),
                  ButtonApp(
                    model: ButtonAppModel(
                      text: 'Trả lời',
                      onPressed: _sendMessage,
                      enabled: !loading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
