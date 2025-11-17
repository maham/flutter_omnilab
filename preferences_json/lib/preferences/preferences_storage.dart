import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'preferences.dart';

const String _preferencesFileName = 'preferences.json';
const int _numBackups = 10;

Future<String> get _tmpFilePath async {
  final directory = await getTemporaryDirectory();
  final tmpFilePath = join(directory.path, _preferencesFileName);

  return tmpFilePath;
}

Future<String> get _preferencesFilePath async {
  final directory = await getApplicationSupportDirectory();
  final preferencesFilePath = join(directory.path, _preferencesFileName);

  return preferencesFilePath;
}

Future<void> _saveJson(Map<String, dynamic> data) async {
  const encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(data);
  await _saveString(jsonString);
}

Future<void> _saveString(String data) async {
  final tmpPath = await _tmpFilePath;
  debugPrint('tmpPath = $tmpPath');

  try {
    final tmpFile = File(await _tmpFilePath);
    await tmpFile.writeAsString(data, flush: true);
    final finalPath = await _preferencesFilePath;
    await tmpFile.rename(finalPath);
  } on IOException catch (error, stackTrace) {
    throw PreferencesSaveException(
      'Could not save preferences',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

Future<Map<String, dynamic>> _loadJson() async {
  final jsonString = await _loadString();
  final jsonData = jsonDecode(jsonString);

  return jsonData;
}

Future<String> _loadString() async {
  final path = await _preferencesFilePath;
  final preferencesFile = File(path);
  final jsonString = await preferencesFile.readAsString();
  debugPrint('jsonString\n$jsonString');

  return jsonString;
}

Future<void> _rotateBackups() async {
  await _deleteOldestBackup();
  await _shiftBackups();

  final current = File('$_preferencesFilePath');

  if (await current.exists()) {
    await current.rename('$_preferencesFilePath.1');
  }
}

Future<void> _deleteOldestBackup() async {
  final oldest = File('$_preferencesFilePath.$_numBackups');

  if (await oldest.exists()) {
    await oldest.delete();
  }
}

Future<void> _shiftBackups() async {
  for (int fileSuffix = _numBackups - 1; fileSuffix >= 1; fileSuffix--) {
    final oldFile = File('$_preferencesFilePath.$fileSuffix');

    if (await oldFile.exists()) {
      final newFile = File('$_preferencesFilePath.${fileSuffix + 1}');
      await oldFile.rename(newFile.path);
    }
  }
}

class PreferencesStorage {
  static const Duration _debounceTimeout = Duration(seconds: 1);

  final Preferences _preferences;
  Timer? _debounce;
  bool _saving = false;
  bool _pending = false;

  PreferencesStorage(this._preferences) {
    _preferences.addListener(_preferencesUpdated);
  }

  dispose() {
    _preferences.removeListener(_preferencesUpdated);
  }

  static Future<Map<String, dynamic>> load() async {
    try {
      return _loadJson();
    } on FileSystemException catch (_) {
      await _rotateBackups();
      return {};
    }
  }

  void _preferencesUpdated() {
    _debounce?.cancel();
    _debounce = Timer(_debounceTimeout, () {
      _pending = true;
      _save();
    });
  }

  Future<void> _save() async {
    if (!_saving) {
      _saving = true;

      while (_pending) {
        _pending = false;
        await _saveJson(_preferences.toJson());
      }

      _saving = false;
    }
  }
}

class PreferencesStorageException implements Exception {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  const PreferencesStorageException(
    this.message, {
    this.error,
    this.stackTrace,
  });

  @override
  String toString() {
    return '$runtimeType: $message'
        '${error != null ? ' (Cause: $error)' : ''}'
        '${stackTrace != null ? '\n$stackTrace' : ''}';
  }
}

class PreferencesSaveException extends PreferencesStorageException {
  const PreferencesSaveException(
    super.message, {
    super.error,
    super.stackTrace,
  });
}
