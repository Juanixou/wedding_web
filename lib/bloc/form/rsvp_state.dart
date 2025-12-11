import 'package:equatable/equatable.dart';
import 'package:wedding_web/models/rsvp_form.dart';

abstract class RSVPState extends Equatable {
  const RSVPState();

  @override
  List<Object?> get props => [];
}

class RSVPInitial extends RSVPState {
  final RSVPForm form;

  const RSVPInitial({required this.form});

  @override
  List<Object?> get props => [form];
}

class RSVPSubmitting extends RSVPState {
  final RSVPForm form;

  const RSVPSubmitting({required this.form});

  @override
  List<Object?> get props => [form];
}

class RSVPSuccess extends RSVPState {
  final String message;

  const RSVPSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RSVPError extends RSVPState {
  final String message;
  final RSVPForm form;

  const RSVPError({required this.message, required this.form});

  @override
  List<Object?> get props => [message, form];
}

