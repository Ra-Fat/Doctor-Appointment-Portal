import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  final password = '123';
  final bytes = utf8.encode(password);
  final digest = sha256.convert(bytes);
  print(digest.toString());
}
