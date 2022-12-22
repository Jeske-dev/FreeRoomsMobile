part of 'update_bloc.dart';

@immutable
abstract class UpdateState extends Equatable{
  const UpdateState();
}

class UpdateInitial extends UpdateState {
  const UpdateInitial();

  @override
  List<Object?> get props => [];
}

class UpdateLoaded extends UpdateState {
  final String currentVersionNumber;
  final String latestVersionNumber;
  final String description;
  final String directUrl;
  final String gerneralUrl;

  const UpdateLoaded({
    required this.currentVersionNumber,
    required this.latestVersionNumber,
    required this.description,
    required this.directUrl,
    required this.gerneralUrl
  });

  @override
  List<Object?> get props => [currentVersionNumber, latestVersionNumber, description, directUrl, gerneralUrl];
}