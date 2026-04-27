import 'package:flutter/material.dart';

class AsyncUserScreen extends StatefulWidget {
  const AsyncUserScreen({super.key});

  @override
  State<AsyncUserScreen> createState() => _AsyncUserScreenState();
}

class _AsyncUserScreenState extends State<AsyncUserScreen> {
  String _message = 'Press the button to load user.';
  bool _isLoading = false;
  bool _isLoaded = false;

  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
      _isLoaded = false;
      _message = 'Loading user...';
    });

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _isLoaded = true;
      _message = 'User loaded successfully!';
    });
  }

  void _reset() {
    setState(() {
      _message = 'Press the button to load user.';
      _isLoading = false;
      _isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IconData statusIcon;

    if (_isLoading) {
      statusIcon = Icons.hourglass_empty;
    } else if (_isLoaded) {
      statusIcon = Icons.check_circle;
    } else {
      statusIcon = Icons.person;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Programming Exercise'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  size: 70,
                  color: _isLoaded ? Colors.green : Colors.blue,
                ),
                const SizedBox(height: 18),

                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                if (_isLoading)
                  const CircularProgressIndicator(),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _loadUser,
                    icon: const Icon(Icons.download),
                    label: const Text('Load User'),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}