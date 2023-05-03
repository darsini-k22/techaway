import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Providers/CartItemsProvider.dart';
import 'package:techaway/components/Providers/CurrentIndexProvider.dart';
import 'package:techaway/components/Providers/FoodIDataProvider.dart';
import 'package:techaway/components/Providers/OrderDataProvider.dart';
import 'package:techaway/components/Providers/UserDataProvider.dart';
import 'package:techaway/components/Providers/Themeprovider.dart';
import 'package:techaway/components/userCredentials/UserLogin.dart';
import 'package:techaway/components/homePage/homeBody.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:techaway/components/homePage/searchBar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 10));
  FlutterNativeSplash.remove();
  // FirebaseAuth.instance.setPersistence(
  //     Persistence.LOCAL);

  // check if user is already logged in
  // User? user = FirebaseAuth.instance.currentUser;
  // Widget initialScreen = user != null ? MyHomePage() : LoginPage();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
        ChangeNotifierProvider(create: (context) => CartItemProvider()),
        ChangeNotifierProvider(create: (context) => FoodDataProvider()),
        ChangeNotifierProvider(create: (context) => OrderDataProvider()),
        ChangeNotifierProvider(create: (context) => UserDataProvider())
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
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).theme.copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                    bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'Nunito',
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
            ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildFutureBuilder();
              } else {
                return LoginPage();
              }
            })

        // MyHomePage(),
        );
  }

  FutureBuilder<FirebaseApp> buildFutureBuilder() {
    return FutureBuilder(
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
    );
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
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
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
          title: Text(
            'Tech Away',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800),
          ),
          expandedHeight: 280.0,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/fastFoodBg.png"),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrange.shade500, Colors.amber.shade700],
                  ),
                ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:65),
                    child: Column(children: [Padding(
                      padding: const EdgeInsets.only(left:18,top: 38),
                      child: Container(
                        child: Text(
                          "Put Somthing Yummy In You Tummy 😋",
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                      SearchBar()],),
                  )

                ],
              ),
            ),
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

Future<void> loadFont() async {
  await rootBundle.load('assets/fonts/Nunito-Italic-VariableFont_wght.ttf');
  await rootBundle.load('assets/fonts/Nunito-variableFont_wght.ttf');
}
