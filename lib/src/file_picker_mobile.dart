import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';

import 'file_picker_io.dart';

/// Implementation of file selection dialog using file_picker for mobile platforms
Future<Map<String, Uint8List>> selectFilesMobile(
    {FileTypeCross type, String fileExtension}) async {
  PlatformFile file = (await FilePicker.platform.pickFiles(
          type: fileTypeCrossParse(type),
          allowedExtensions: parseExtension(fileExtension)))
      .files[0];
  return {file.path: file.bytes};
}

/// Implementation of file selection dialog for multiple files using file_picker for mobile platforms
Future<Map<String, Uint8List>> selectMultipleFilesMobile(
    {FileTypeCross type, String fileExtension}) async {
  List<PlatformFile> files = (await FilePicker.platform.pickFiles(
          type: fileTypeCrossParse(type),
          allowMultiple: true,
          allowedExtensions: parseExtension(fileExtension)))
      .files;
  Map<String, Uint8List> filesMap = {};
  files.forEach((file) {
    filesMap[file.path] = file.bytes;
  });
  return filesMap;
}

Future<String> saveFileMobile(
    {FileTypeCross type, String fileExtension}) async {
  /// TODO: implement
  throw UnimplementedError('Unsupported Platform for file_picker_cross');
}
