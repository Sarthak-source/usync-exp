import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactViewModel extends BaseViewModel {
  final List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  void requestContactsPermission() async {
    final PermissionStatus permissionStatus =
        await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      // Permission granted, continue to get contacts
      getContacts();
    } else {
      // Permission denied, show error message
      debugPrint('Permission denied');
    }
  }

  void getContacts() async {
    // Get all contacts on the device
    Iterable<Contact> contacts = await ContactsService.getContacts();

    // Add each contact to our list

    _contacts.addAll(contacts.toList());
    notifyListeners();
  }

  Future<void> sendSms(String phone, String messageBody) async {
    final uri = Uri.parse(Platform.isAndroid
        ? 'sms:$phone?body=${Uri.encodeQueryComponent(messageBody)}'
        : 'sms:$phone&body=${Uri.encodeQueryComponent(messageBody)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
