import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/create_reaction_screen.dart';

void main() {
  runApp(const DiscordBotApp());
}

class DiscordBotApp extends StatelessWidget {
  const DiscordBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discord Reaction Roles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF5865F2), // Discord Blurple
        scaffoldBackgroundColor: const Color(0xFF36393F), // Discord Dark Gray
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2F3136),
          elevation: 0,
          centerTitle: true,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5865F2),
          secondary: Color(0xFF3BA55C), // Discord Green
          surface: Color(0xFF2F3136),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/create': (context) => const CreateReactionScreen(),
      },
    );
  }
}
