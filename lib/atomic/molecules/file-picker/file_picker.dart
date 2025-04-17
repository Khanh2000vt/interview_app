import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:interview_app/atomic/atoms/button/button_app.dart';
import 'package:interview_app/atomic/atoms/button/button_app_model.dart';
import 'package:interview_app/enums/common.dart';

class FilePickerApp extends StatefulWidget {
  const FilePickerApp({super.key, this.onFilePicked});

  final void Function(FilePickerResult file)? onFilePicked;

  @override
  State<FilePickerApp> createState() => _FilePickerAppState();
}

class _FilePickerAppState extends State<FilePickerApp> {
  String? fileName;
  Future<void> handlePickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      widget.onFilePicked?.call(result);
      setState(() {
        fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonApp(
      model: ButtonAppModel(
        text: fileName ?? 'Chọn file',
        onPressed: handlePickerFile,
        type: EButtonType.outlined,
      ),
    );
  }
}
