// part 'about_state.dart';

abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoaded extends AboutState {
  final String version;
  final String description;
  final String contact;

  AboutLoaded(
      {required this.version,
      required this.description,
      required this.contact});
}
