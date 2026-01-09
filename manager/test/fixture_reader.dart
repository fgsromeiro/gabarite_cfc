import 'dart:convert';
import 'dart:io';

Map<String, dynamic> fixture(String name) =>
    json.decode(File('assets/fixtures/$name').readAsStringSync());
