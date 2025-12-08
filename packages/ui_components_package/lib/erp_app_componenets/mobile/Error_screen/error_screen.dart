import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? detail;
  final dynamic? data;
  final Uri? uri;
  final VoidCallback? onRetry;

  const ErrorPage({super.key, this.detail, this.data, this.uri, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFABABAB), Color(0x00ABABAB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                detail ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                data.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),

              const SizedBox(height: 15),

              if (uri != null)
                Text(
                  "URI: $uri",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: const Text("Retry"),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
