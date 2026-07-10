import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SimpleLayout(),
  ));
}

class SimpleLayout extends StatefulWidget {
  const SimpleLayout({super.key});

  @override
  State<SimpleLayout> createState() => _SimpleLayoutState();
}

class _SimpleLayoutState extends State<SimpleLayout> {
  String _message = "اضغط على الزر لإجراء الاتصال";

  Future<void> _makeRequest() async {
    setState(() {
      _message = "جاري الاتصال...";
    });

    try {
      final client = HttpClient();
      final uri = Uri.parse('https://eos4rirjsl8yp5z.m.pipedream.net');
      final request = await client.postUrl(uri);
      final response = await request.close();

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _message = "تم الاتصال بنجاح! ✅\nرمز الحالة: ${response.statusCode}";
        });
      } else {
        setState(() {
          _message = "استجاب السيرفر برمز مختلف: ${response.statusCode}";
        });
      }
      client.close();
    } catch (e) {
      setState(() {
        _message = "فشل الاتصال بالشبكة.\nالسبب: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تطبيق الاتصال الأساسي")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _makeRequest,
                child: const Text("اتصال الآن"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
