/// Represents the app wide state.
///
/// The AppState is made immutable as it will be shared by an [InheritedModel]
/// and to be regarded as static data by the widget tree.
///
class AppState {
  final int firstCounter;
  final int secondCounter;

  const AppState({required this.firstCounter, required this.secondCounter});

  /// Creates a new [AppState] with optional fields modified.
  ///
  AppState copyWith({int? firstCounter, int? secondCounter}) {
    return AppState(
      firstCounter: firstCounter ?? this.firstCounter,
      secondCounter: secondCounter ?? this.secondCounter,
    );
  }

  @override
  String toString() {
    return 'AppState: (firstCounter: $firstCounter, secondCounter: $secondCounter)';
  }
}
