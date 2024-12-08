import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const Index()),
  );
}
