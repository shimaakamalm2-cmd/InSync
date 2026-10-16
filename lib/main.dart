import 'package:insync/flutter_view.dart';
import 'package:material_ui/material_ui.dart';
import 'package:m3e_core/m3e_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        canvasColor: Colors.blue,
        bottomNavigationBarTheme: .new(backgroundColor: Colors.blue, selectedItemColor: Colors.blue, unselectedItemColor: Colors.red),
        colorScheme: M3EColorScheme.light(
          seedColor: Colors.white,
          variant: M3EColorVariant.monochrome, // Instantly unlocks expressive hue-rotations
          contrastLevel: 0.0, // Adjust from -1.0 to 1.0
        ),
      ),
      home: MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  String title;

  MyHomePage({required this.title});

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  int selectedIndex = 0;
  List<NavigationDestination> navigationViews = [
    NavigationDestination(key: Key("0"), icon: Icon(Icons.home), label: "Home"),
    NavigationDestination(key: Key("1"), icon: Icon(Icons.settings), label: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: NavigationBar(
        destinations: navigationViews,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
      ),

      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
      ),
      body: [SampleView(), TheSupposedlyNativeView()][selectedIndex]
    );
  }
}
