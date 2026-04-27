import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreen extends StatefulWidget {
  const SharedPreferencesScreen({super.key});

  @override
  State<SharedPreferencesScreen> createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _savedName = '';
  String _savedAge = '';
  String _savedEmail = '';
  String _savedTime = '';
  String _message = 'No data available';

  Future<void> _saveUserData() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _message = 'Please enter a name before saving.';
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toString();

    await prefs.setString('username', name);
    await prefs.setString('age', age);
    await prefs.setString('email', email);
    await prefs.setString('lastSavedTime', now);

    setState(() {
      _message = 'User data saved successfully!';
    });

    _nameController.clear();
    _ageController.clear();
    _emailController.clear();
  }

  Future<void> _showUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('username');
    final age = prefs.getString('age') ?? '';
    final email = prefs.getString('email') ?? '';
    final time = prefs.getString('lastSavedTime') ?? '';

    if (name == null || name.isEmpty) {
      setState(() {
        _savedName = '';
        _savedAge = '';
        _savedEmail = '';
        _savedTime = '';
        _message = 'No saved data found.';
      });
      return;
    }

    setState(() {
      _savedName = name;
      _savedAge = age;
      _savedEmail = email;
      _savedTime = time;
      _message = 'Saved user data loaded.';
    });
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('username');
    await prefs.remove('age');
    await prefs.remove('email');
    await prefs.remove('lastSavedTime');

    setState(() {
      _savedName = '';
      _savedAge = '';
      _savedEmail = '';
      _savedTime = '';
      _message = 'Saved data cleared.';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

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

  @override
  Widget build(BuildContext context) {
    final hasSavedData = _savedName.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Exercise'),
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
                    const Icon(
                      Icons.save_alt,
                      size: 50,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Save User Information',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _buildInputField(
                      controller: _nameController,
                      label: 'Enter name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _ageController,
                      label: 'Enter age',
                      icon: Icons.calendar_month,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    _buildInputField(
                      controller: _emailController,
                      label: 'Enter email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _saveUserData,
                            icon: const Icon(Icons.save),
                            label: const Text('Save Name'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showUserData,
                            icon: const Icon(Icons.visibility),
                            label: const Text('Show Name'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _clearUserData,
                        icon: const Icon(Icons.delete),
                        label: const Text('Clear Data'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Card(
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
                      'Saved Data',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (hasSavedData) ...[
                      _buildInfoRow(
                        icon: Icons.person,
                        label: 'Name',
                        value: _savedName,
                      ),
                      _buildInfoRow(
                        icon: Icons.calendar_month,
                        label: 'Age',
                        value: _savedAge,
                      ),
                      _buildInfoRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: _savedEmail,
                      ),
                      _buildInfoRow(
                        icon: Icons.access_time,
                        label: 'Last saved',
                        value: _savedTime,
                      ),
                    ] else
                      const Text(
                        'No saved data to display.',
                        style: TextStyle(fontSize: 15),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      _message,
                      style: TextStyle(
                        color: hasSavedData ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}