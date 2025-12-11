import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_web/bloc/form/rsvp_state.dart';
import 'package:wedding_web/models/rsvp_form.dart';
import 'package:wedding_web/repositories/rsvp_repository.dart';

class RSVPCubit extends Cubit<RSVPState> {
  final RSVPRepository repository;

  RSVPCubit({required this.repository})
      : super(RSVPInitial(
          form: RSVPForm(name: ''),
        ));

  RSVPForm _getCurrentForm() {
    if (state is RSVPInitial) {
      return (state as RSVPInitial).form;
    } else if (state is RSVPError) {
      return (state as RSVPError).form;
    } else if (state is RSVPSubmitting) {
      return (state as RSVPSubmitting).form;
    }
    return RSVPForm(name: '');
  }

  void updateName(String name) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(name: name)));
  }

  void updateHasCompanion(bool hasCompanion) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(
      form: currentForm.copyWith(
        hasCompanion: hasCompanion,
        companionName: hasCompanion ? currentForm.companionName : null,
      ),
    ));
  }

  void updateCompanionName(String? companionName) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(companionName: companionName)));
  }

  void toggleAllergy(String allergy) {
    final currentForm = _getCurrentForm();
    final allergies = List<String>.from(currentForm.allergies);
    if (allergies.contains(allergy)) {
      allergies.remove(allergy);
    } else {
      allergies.add(allergy);
    }
    emit(RSVPInitial(form: currentForm.copyWith(allergies: allergies)));
  }

  void updateOtherAllergies(String? otherAllergies) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(otherAllergies: otherAllergies)));
  }

  void updateNeedsBus(bool needsBus) {
    final currentForm = _getCurrentForm();
    emit(RSVPInitial(form: currentForm.copyWith(needsBus: needsBus)));
  }

  Future<void> submitForm() async {
    final currentForm = _getCurrentForm();
    
    if (currentForm.name.isEmpty) {
      emit(RSVPError(
        message: 'El nombre es obligatorio',
        form: currentForm,
      ));
      return;
    }

    if (currentForm.hasCompanion && (currentForm.companionName == null || currentForm.companionName!.isEmpty)) {
      emit(RSVPError(
        message: 'El nombre del acompañante es obligatorio',
        form: currentForm,
      ));
      return;
    }

    emit(RSVPSubmitting(form: currentForm));

    try {
      await repository.submitRSVP(currentForm);
      emit(RSVPSuccess(message: '¡Gracias por confirmar tu asistencia!'));
    } catch (e) {
      emit(RSVPError(
        message: 'Error al enviar el formulario: ${e.toString()}',
        form: currentForm,
      ));
    }
  }

  void resetForm() {
    emit(RSVPInitial(form: RSVPForm(name: '')));
  }
}

