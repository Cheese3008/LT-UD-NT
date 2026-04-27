import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FactorialIsolateScreen extends StatefulWidget {
  const FactorialIsolateScreen({super.key});

  @override
  State<FactorialIsolateScreen> createState() => _FactorialIsolateScreenState();
}

class _FactorialIsolateScreenState extends State<FactorialIsolateScreen> {
  final TextEditingController _numberController =
      TextEditingController(text: '30000');

  bool _isLoading = false;
  FactorialResult? _result;
  String _message = 'Enter a number and start calculation.';

  Future<void> _calculateFactorial() async {
    final inputText = _numberController.text.trim();
    final number = int.tryParse(inputText);

    if (number == null || number < 0) {
      setState(() {
        _message = 'Please enter a valid positive number.';
        _result = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _result = null;
      _message = 'Calculating $number! using isolate...';
    });

    try {
      final result = await compute(calculateLargeFactorial, number);

      if (!mounted) return;

      setState(() {
        _result = result;
        _message = 'Calculation completed successfully!';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _message = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _reset() {
    setState(() {
      _result = null;
      _message = 'Enter a number and start calculation.';
      _isLoading = false;
      _numberController.text = '30000';
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  Widget _buildResultCard() {
    final result = _result;

    if (result == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 3,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Factorial Result',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _InfoRow(
              icon: Icons.tag,
              label: 'Number',
              value: '${result.number}!',
            ),
            _InfoRow(
              icon: Icons.format_list_numbered,
              label: 'Total digits',
              value: result.totalDigits.toString(),
            ),
            _InfoRow(
              icon: Icons.timer,
              label: 'Calculation time',
              value: '${result.elapsedMilliseconds} ms',
            ),
            const SizedBox(height: 12),
            const Text(
              'First digits:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SelectableText(result.firstDigits),
            const SizedBox(height: 12),
            const Text(
              'Last digits:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SelectableText(result.lastDigits),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusIcon = _isLoading ? Icons.memory : Icons.calculate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Factorial Exercise'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      statusIcon,
                      size: 60,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Large Factorial Calculator',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This task uses compute() to run heavy calculation in another isolate.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: 'Enter number',
                        hintText: 'Example: 30000',
                        prefixIcon: const Icon(Icons.numbers),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      _message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _isLoading ? Colors.orange : Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (_isLoading) ...[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      const Text(
                        'Please wait. The UI is still responsive because the calculation is running in an isolate.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _calculateFactorial,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Calculate Factorial'),
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
            const SizedBox(height: 18),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class FactorialResult {
  final int number;
  final int totalDigits;
  final String firstDigits;
  final String lastDigits;
  final int elapsedMilliseconds;

  const FactorialResult({
    required this.number,
    required this.totalDigits,
    required this.firstDigits,
    required this.lastDigits,
    required this.elapsedMilliseconds,
  });
}

FactorialResult calculateLargeFactorial(int number) {
  final stopwatch = Stopwatch()..start();

  BigInt result = BigInt.one;

  for (int i = 2; i <= number; i++) {
    result *= BigInt.from(i);
  }

  final resultText = result.toString();
  stopwatch.stop();

  return FactorialResult(
    number: number,
    totalDigits: resultText.length,
    firstDigits: resultText.length > 80
        ? resultText.substring(0, 80)
        : resultText,
    lastDigits: resultText.length > 80
        ? resultText.substring(resultText.length - 80)
        : resultText,
    elapsedMilliseconds: stopwatch.elapsedMilliseconds,
  );
}