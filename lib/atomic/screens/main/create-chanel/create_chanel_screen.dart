import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/atoms/button/button_app.dart';
import 'package:interview_app/atomic/atoms/button/button_app_model.dart';
import 'package:interview_app/atomic/atoms/text/text_app.dart';
import 'package:interview_app/atomic/molecules/file-picker/file_picker.dart';
import 'package:interview_app/atomic/molecules/switch/switch_app.dart';
import 'package:interview_app/atomic/organisms/organisms.dart';
import 'package:interview_app/enums/common.dart';
import 'package:interview_app/local/app_database.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/routing/routes.dart';
import 'package:interview_app/themes/scale.dart';
import 'package:uuid/uuid.dart';

class CreateChanelScreen extends StatefulWidget {
  const CreateChanelScreen({super.key});

  @override
  State<CreateChanelScreen> createState() => _CreateChanelScreenState();
}

class _CreateChanelScreenState extends State<CreateChanelScreen> {
  late AppDatabase database;
  bool isCV = true;
  FilePickerResult? file;

  @override
  void initState() {
    super.initState();
    database = AppDatabase();
  }

  @override
  void dispose() {
    database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final formFields = FormAppModel([
      InputFieldModel(
        name: 'job',
        labelText: 'Công việc',
        validators: [
          FormBuilderValidators.required(errorText: 'Vui lòng công việc'),
        ],
      ),
      InputFieldModel(
        name: 'level',
        labelText: 'Kinh nghiệm',
        validators: [
          FormBuilderValidators.required(
            errorText: 'Vui lòng nhập kinh nghiệm',
          ),
        ],
      ),
    ]);

    void unfocusAll() {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    Future<void> onCreateFormInput() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        final formData = formKey.currentState!.value;
        final idRoom = Uuid().v4();
        await database
            .into(database.roomsTable)
            .insert(
              RoomsTableCompanion.insert(
                id: idRoom,
                job: formData['job'],
                level: formData['level'],
              ),
            );

        GoRouter.of(context).go('${Routes.chatDetail}/$idRoom');
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nhập!')));
    }

    Future<void> onCreateFormCV() async {
      if (file == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Nhập!')));
        return;
      }
      final idRoom = Uuid().v4();
      final idFile = Uuid().v4();
      File fileData = File(file!.files.single.path!);
      String fileName = file!.files.single.name;
      Uint8List? fileBytes = file?.files.first.bytes;
      try {
        // Uint8List fileContent = await fileData.readAsBytes();
        await database
            .into(database.filesTable)
            .insert(
              FilesTableCompanion.insert(
                id: idFile,
                fileName: fileName,
                filePath: fileData.path,
                fileContent: fileBytes ?? Uint8List(0),
              ),
            );
        await database
            .into(database.roomsTable)
            .insert(
              RoomsTableCompanion.insert(
                id: idRoom,
                job: 'Phỏng vấn bằng CV',
                level: fileName,
                idFile: Value(idFile),
              ),
            );

        GoRouter.of(context).go('${Routes.chatDetail}/$idRoom');
      } catch (e) {}
    }

    void handleCreateRoom() async {
      if (isCV) {
        onCreateFormCV();
        return;
      }
      onCreateFormInput();
    }

    return GestureDetector(
      onTap: unfocusAll,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const TextApp(
            'Tạo một phòng hỏng vấn',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: scaleW(16), right: scaleW(16)),
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      SwitchApp(
                        label: 'Phỏng vấn bằng CV',
                        value: isCV,
                        onChanged: (v) {
                          setState(() {
                            isCV = v;
                          });
                        },
                      ),
                      isCV
                          ? FilePickerApp(
                            onFilePicked: (f) {
                              file = f;
                            },
                          )
                          : FormApp(formFields, formKey: formKey),
                    ],
                  ),
                ),
                ButtonApp(
                  model: ButtonAppModel(
                    text: 'Tạo',
                    type: EButtonType.tonal,
                    onPressed: handleCreateRoom,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
