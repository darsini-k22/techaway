import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/CurrentIndexProvider.dart';
import 'package:techaway/components/Themeprovider.dart';
import 'package:techaway/components/homePage/homeBody.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: context.watch<ThemeProvider>().theme,
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("You have an Error ${snapshot.error.toString()}");
              return Text("Something went wrong");
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
        // MyHomePage(),
        );
    ;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final currentIndexProvider = Provider.of<CurrentIndexProvider>(context);

    return Scaffold(
        body: IndexedStack(
          children: currentIndexProvider.screens,
          index: currentIndexProvider.currentIndex,
        ),
        bottomNavigationBar: BottomNavigator(
            onTap: (index) {
              setState(() {
                currentIndexProvider.setCurrentIndex(index);
              });
            },
            context: context,
            currentIndex: currentIndexProvider.currentIndex));
  }
}

class BottomNavigator extends StatefulWidget {
  final Function(int) onTap;
  final BuildContext context;
  final int currentIndex;

  const BottomNavigator({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.context,
  }) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 25,
      showUnselectedLabels: false,
      selectedItemColor: Colors.green,
      onTap: widget.onTap,
      currentIndex: widget.currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.green,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.green,
          ),
          label: 'My Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_shopping_cart_sharp,
            color: Colors.green,
          ),
          label: 'My Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.green,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('My App'),
          expandedHeight: 280.0,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrange.shade500, Colors.amber.shade700],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Positioned(
                      left: 0,
                      child: Image.asset(
                        "assets/images/chief.png",
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                  ],
                )),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return homeBody();
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
