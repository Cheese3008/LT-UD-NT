import 'package:flutter/material.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> avatarImages = [
      'assets/images/9.png',
      'assets/images/10.png',
      'assets/images/11.png',
      'assets/images/12.png',
      'assets/images/15.png',
      'assets/images/16.png',
      'assets/images/17.png',
      'assets/images/18.png',
      'assets/images/19.png',
      'assets/images/20.png',
    ];

    final List<Contact> contacts = List.generate(
      10,
      (index) => Contact(
        name: 'Contact ${index + 1}',
        phone: '090${index + 1} 123 456',
        email: 'contact${index + 1}@gmail.com',
        avatarPath: avatarImages[index],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Exercise'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(contact.avatarPath),
              ),
              title: Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16),
                        const SizedBox(width: 6),
                        Text(contact.phone),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 16),
                        const SizedBox(width: 6),
                        Text(contact.email),
                      ],
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Message ${contact.name}'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Contact {
  final String name;
  final String phone;
  final String email;
  final String avatarPath;

  const Contact({
    required this.name,
    required this.phone,
    required this.email,
    required this.avatarPath,
  });
}