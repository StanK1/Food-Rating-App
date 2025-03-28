import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'screens/home_screen.dart';
import 'screens/Register_screen.dart';

// Global error handler to prevent app crashes
void _handleError(Object error, StackTrace stack) {
  // Log the error but don't crash the app
  debugPrint('ERROR: $error');
  debugPrint('STACK: $stack');
}

Future<void> main() async {
  // Capture Flutter errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _handleError(details.exception, details.stack ?? StackTrace.empty);
  };

  // Capture async errors that don't go through Flutter error handling
  runZonedGuarded(() async {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Add more error handling for platform channels
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            'Something went wrong.\nPlease restart the app.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    };

    // Run the app
    runApp(const MyApp());
  }, _handleError);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choconavt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Add font family if using a custom font
        fontFamily: 'Inter',
        // Make app look more modern by using Material 3
        useMaterial3: true,
        // Use dark theme for better contrast with the app's dark background
        brightness: Brightness.dark,
      ),
      home: Builder(
        builder: (context) {
          // Catch any errors during home screen initialization
          try {
            return const HomeScreen();
          } catch (e, stack) {
            debugPrint('Error initializing home screen: $e');
            debugPrint('$stack');
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFF05032A), Color(0xFF585670)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/astro.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      routes: {
        '/register': (context) => const SignUp1(),
      },
    );
  }
}
