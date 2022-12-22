part of 'update_bloc.dart';

@immutable
abstract class UpdateEvent {
  const UpdateEvent();
}

class LoadUpdate extends UpdateEvent {
  final String currentVersionNumber;
  final String latestVersionNumber;
  final String description;
  final String directUrl;
  final String generalUrl;

  const LoadUpdate({
    required this.currentVersionNumber,
    required this.latestVersionNumber,
    required this.description,
    required this.directUrl,
    required this.generalUrl
  });
}