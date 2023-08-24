import 'package:desktop_app/home_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'save documents',
      home: Directionality(textDirection: TextDirection.rtl, child: HomePage()),
    );
  }
}
