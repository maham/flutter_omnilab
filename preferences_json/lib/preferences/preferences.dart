import 'package:flutter/widgets.dart';

import 'preferences_model.dart';
import 'preferences_writer.dart';

class Preferences extends ChangeNotifier implements PreferencesWriter {
  bool _aBool;
  int _aNumber;
  String _aString;
  Object? _aNull;
  List<String> _aStringList;
  Set<PreferencesModelAspect> _updatedAspects = {};

  Preferences({
    bool aBool = false,
    int aNumber = 1234,
    String aString = 'Hello filesystem!',
    Object? aNull,
    List<String> aStringList = const [],
  }) : _aBool = aBool,
       _aNumber = aNumber,
       _aString = aString,
       _aNull = aNull,
       _aStringList = aStringList;

  bool get aBool => _aBool;
  int get aNumber => _aNumber;
  String get aString => _aString;
  Object? get aNull => _aNull;
  List<String> get aStringList => _aStringList;
  Set<PreferencesModelAspect> get updatedAspects => _updatedAspects;

  @override
  set aBool(bool isSet) {
    _aBool = isSet;
    _updatedAspects = {PreferencesModelAspect.aBool};
    notifyListeners();
  }

  @override
  set aNumber(int anotherNumber) {
    _aNumber = anotherNumber;
    _updatedAspects = {PreferencesModelAspect.aNumber};
    notifyListeners();
  }

  @override
  set aString(String anotherString) {
    _aString = anotherString;
    _updatedAspects = {PreferencesModelAspect.aString};
    notifyListeners();
  }

  set aNull(Object? anObject) {
    _aNull = anObject;
    notifyListeners();
  }

  set aStringList(List<String> anotherStringList) {
    _aStringList = anotherStringList;
    notifyListeners();
  }

  static Preferences fromJson(Map<String, dynamic> json) {
    final theBool = json['bool'] as bool;
    final theNumber = json['int'] as int;
    final theString = json['string'] as String;
    final theNull = json['null'] as Object?;
    final theDynamicList = json['List<String>'] as List<dynamic>;
    final theStringList = List<String>.from(theDynamicList);

    return Preferences(
      aBool: theBool,
      aNumber: theNumber,
      aString: theString,
      aNull: theNull,
      aStringList: theStringList,
    );
  }

  void updateWith(Map<String, dynamic> json) {
    _updatedAspects = {};

    T? trackChange<T>(PreferencesModelAspect aspect, T? value) {
      if (value != null) {
        _updatedAspects.add(aspect);
      }

      return value;
    }

    final theBool = json['bool'] as bool?;
    final theNumber = json['int'] as int?;
    final theString = json['string'] as String?;
    final theNull = json['null'] as Object?;
    final theDynamicList = json['List<String>'] as List<dynamic>?;
    final theStringList = theDynamicList != null
        ? List<String>.from(theDynamicList)
        : null;

    _aBool = trackChange(PreferencesModelAspect.aBool, theBool) ?? aBool;
    _aNumber =
        trackChange(PreferencesModelAspect.aNumber, theNumber) ?? aNumber;
    _aString =
        trackChange(PreferencesModelAspect.aString, theString) ?? aString;
    _aNull = theNull ?? aNull;
    _aStringList = theStringList ?? aStringList;

    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'bool': aBool,
      'int': aNumber,
      'string': aString,
      'null': aNull,
      'List<String>': aStringList,
    };
  }
}
