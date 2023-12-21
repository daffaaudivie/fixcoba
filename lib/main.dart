import 'package:flutter/material.dart';
import 'package:fixcoba/home_page.dart';
import 'package:fixcoba/order_page.dart';
import 'package:fixcoba/transaksi_page.dart';
import 'package:fixcoba/profile_page.dart';
import 'package:fixcoba/login_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RootPage(),
      initialRoute: '/',
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    Transaksi(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMBASE'),
        leadingWidth: 0,
      ),
      body: pages[currentPage],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating Action Button');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          // NavigationDestination(
          //     icon: Icon(Icons.shopping_cart_rounded), label: 'Order'),
          NavigationDestination(
              icon: Icon(Icons.card_membership), label: 'Transaksi'),
          // NavigationDestination(
          //     icon: Icon(Icons.money), label: 'Pembayaran'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Pangkalan'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
