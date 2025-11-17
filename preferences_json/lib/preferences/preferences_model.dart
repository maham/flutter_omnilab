import 'package:flutter/widgets.dart';

import 'preferences_writer.dart';

enum PreferencesModelAspect { aBool, aNumber, aString }

class PreferencesModel extends InheritedModel<PreferencesModelAspect> {
  final bool aBool;
  final int aNumber;
  final String aString;
  final PreferencesWriter writer;
  final Set<PreferencesModelAspect> lastUpdatedAspects;

  const PreferencesModel({
    super.key,
    required super.child,
    required this.aBool,
    required this.aNumber,
    required this.aString,
    required this.writer,
    this.lastUpdatedAspects = const {},
  });

  static PreferencesModel? maybeOf(
    BuildContext context, [
    PreferencesModelAspect? aspect,
  ]) => InheritedModel.inheritFrom<PreferencesModel>(context, aspect: aspect);

  static PreferencesModel of(
    BuildContext context, [
    PreferencesModelAspect? aspect,
  ]) {
    final PreferencesModel? model = maybeOf(context, aspect);
    assert(model != null, 'No PreferencesModel found in widget tree.');
    return model!;
  }

  static PreferencesModel read(BuildContext context) {
    final model =
        context
                .getElementForInheritedWidgetOfExactType<PreferencesModel>()
                ?.widget
            as PreferencesModel?;
    assert(model != null, 'No PreferencesModel found in widget tree.');
    return model!;
  }

  @override
  bool updateShouldNotify(PreferencesModel oldModel) {
    return this != oldModel;
  }

  @override
  bool updateShouldNotifyDependent(
    PreferencesModel oldModel,
    Set<PreferencesModelAspect> dependencies,
  ) {
    debugPrint(
      'PreferencesModel::updateShouldNotifyDependent(): dependencies = $dependencies',
    );
    return dependencies.intersection(lastUpdatedAspects).isNotEmpty;
  }
}
