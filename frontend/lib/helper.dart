/**
 * Helper functions that is used globally
 */

import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

// Secret is a
class Secret {
  static final Secret _secret = Secret._instance();

  String mapboxKey = "";

  Secret._instance();

  factory Secret() {
    return _secret;
  }

  void _load(Map<String, dynamic> json) {
    this.mapboxKey = json["mapboxKey"];
  }
}

class SecretLoader {
  final String path;
  final String? alt;

  SecretLoader({required this.path, this.alt});

  Future<Secret> _load(String path) {
    return rootBundle.loadStructuredData<Secret>(path, (jsonStr) async {
      final secret = Secret().._load(json.decode(jsonStr));
      return secret;
    });
  }

  Future<Secret> load() async {
    Secret secret;
    try {
      secret = await _load(this.path);
    } catch (e) {
      secret = await _load(this.alt!);
    }
    return secret;
  }
}
