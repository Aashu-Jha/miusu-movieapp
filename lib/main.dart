import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miusu/data/tables/movie_table.dart';
import 'package:miusu/presentation/movie_app.dart';
import 'package:pedantic/pedantic.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'di/get_it.dart' as getIt;

//program starts from here
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());
  unawaited(getIt.init());
  runApp(MovieApp());
}
