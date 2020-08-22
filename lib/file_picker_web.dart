import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'file_picker_cross.dart';

/// Implementation of file selection dialog using dart:html for the web
Future<Map<String, Uint8List>> selectSingleFileAsBytes(
    {FileTypeCross type, String fileExtension}) {
  Completer<Map<String, Uint8List>> loadEnded = Completer();

  String accept = _fileTypeToAcceptString(type, fileExtension);
  html.InputElement uploadInput = html.FileUploadInputElement();
  uploadInput.draggable = true;
  uploadInput.accept = accept;
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    final files = uploadInput.files;
    final file = files[0];
    final reader = new html.FileReader();

    reader.onLoadEnd.listen((e) {
      loadEnded.complete({
        uploadInput.value.replaceAll('\\', '/'):
            Base64Decoder().convert(reader.result.toString().split(",").last)
      });
    });
    reader.readAsDataUrl(file);
  });
  return loadEnded.future;
}

/// Implementation of file selection dialog for the web
Future<String> pickSingleFileAsPath(
    {FileTypeCross type, String fileExtension}) async {
  throw UnimplementedError('Unsupported Platform for file_picker_cross');
}

String _fileTypeToAcceptString(FileTypeCross type, String fileExtension) {
  String accept;
  switch (type) {
    case FileTypeCross.any:
      accept = '';
      break;
    case FileTypeCross.audio:
      accept = 'audio/*';
      break;
    case FileTypeCross.image:
      accept = 'image/*';
      break;
    case FileTypeCross.video:
      accept = 'video/*';
      break;
    case FileTypeCross.custom:
      accept = fileExtension;
      break;
  }
  return accept;
}
