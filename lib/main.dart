import 'package:desktop_app/home_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
      size: Size(1000, 600),
      maximumSize: Size(1000, 800),
      minimumSize: Size(1000, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  // await Window.initialize();
  // await Window.setEffect(
  //   effect: WindowEffect.acrylic,
  //   color: const Color(0xCC222222),
  // );
  // await Window.setEffect(
  //   effect: WindowEffect.mica,
  //   dark: true,
  // );
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
