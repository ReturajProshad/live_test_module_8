import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(
      name: 'Returaj Proshad',
      email: 'Returajsumon0808@gmail.com',
      phoneNumber: '+8801797602810',
    ),
    Contact(
      name: 'Sumon',
      email: 'sumon0908@gmail.com',
      phoneNumber: '+880192218871',
    ),
    Contact(
      name: 'Jahangir',
      email: 'Jahangirmiya@gmail.com',
      phoneNumber: "01853023018",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].email),
            onTap: () {
              showContactDetails(context, contacts[index]);
            },
          );
        },
      ),
    );
  }

void showContactDetails(BuildContext context, Contact contact) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text(
                'Contact Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(height: 16),
              Text(
                'Name: ${contact.name}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Email: ${contact.email}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Number: ${contact.phoneNumber}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}

class Contact {
  final String name;
  final String email;
  final String phoneNumber;

  Contact({required this.name, required this.email, required this.phoneNumber});
}
