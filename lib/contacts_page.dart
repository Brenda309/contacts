import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      var contactsList = await ContactsService.getContacts();
      setState(() {
        contacts = contactsList.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contacts'.tr())),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final displayName = contact.displayName ?? 'No Name';
          final phoneNumber = contact.phones?.isNotEmpty == true ? contact.phones!.first.value ?? 'No Phone Number' : 'No Phone Number';
          return ListTile(
            title: Text(displayName),
            subtitle: Text(phoneNumber),
          );
        },
      ),
    );
  }
}
