// // import 'dart:html';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as w;

// class PdfApi{
//   static Future<File> saveDocument({
//     required String name,
//     required w.Document pdf,
//   }) async{
//     final bytes =await pdf.save();
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/${name}');
//     await file.writeAsBytes(bytes);
//     return file;

//   }
// }