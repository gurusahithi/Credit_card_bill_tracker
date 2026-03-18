import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/bill_provider.dart';
import 'screens/dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BillProvider(),
      child: MaterialApp(
        title: 'Credit Card Bill Tracker',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const DashboardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
