import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_web/bloc/form/rsvp_cubit.dart';
import 'package:wedding_web/bloc/form/rsvp_state.dart';
import 'package:wedding_web/models/rsvp_form.dart';
import 'package:wedding_web/repositories/rsvp_repository.dart';
import 'package:wedding_web/data/datasources/rsvp_datasource.dart';
import 'package:wedding_web/config/wedding_colors.dart';

class RSVPFormSection extends StatelessWidget {
  const RSVPFormSection({super.key});

  final List<String> allergies = const [
    'Marisco',
    'Frutos secos',
    'Lácteos',
    'Gluten',
    'Otros',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RSVPCubit(
        repository: RSVPRepository(
          dataSource: RSVPDataSourceImpl(),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              '¿Asistirás?',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                color: WeddingColors.textPrimary,
              ),
            ),
            const SizedBox(height: 40),
            
            BlocConsumer<RSVPCubit, RSVPState>(
              listener: (context, state) {
                if (state is RSVPSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: WeddingColors.buttonPrimary,
                    ),
                  );
                  context.read<RSVPCubit>().resetForm();
                } else if (state is RSVPError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: WeddingColors.errorColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RSVPSubmitting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                RSVPForm form;
                if (state is RSVPInitial) {
                  form = state.form;
                } else if (state is RSVPError) {
                  form = state.form;
                } else if (state is RSVPSuccess) {
                  // Después del éxito, el form se resetea, así que usamos uno vacío
                  form = RSVPForm(name: '');
                } else {
                  form = RSVPForm(name: '');
                }
                
                return _buildForm(context, form);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, RSVPForm form) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: WeddingColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: WeddingColors.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: WeddingColors.shadowColor,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Nombre y apellidos
          TextFormField(
            initialValue: form.name,
            decoration: InputDecoration(
              labelText: 'Nombre y apellidos *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: WeddingColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 2, color: WeddingColors.inputFocusedBorder),
              ),
            ),
            onChanged: (value) {
              context.read<RSVPCubit>().updateName(value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // ¿Vienes acompañado?
          Text(
            '¿Vienes acompañado?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ChoiceChip(
                  label: const Text('Sí'),
                  selected: form.hasCompanion,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateHasCompanion(selected);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
              const SizedBox(width: 16),
              ChoiceChip(
                  label: const Text('No'),
                  selected: !form.hasCompanion,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateHasCompanion(!selected);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
            ],
          ),
          
          // Nombre del acompañante (si aplica)
          if (form.hasCompanion) ...[
            const SizedBox(height: 24),
            TextFormField(
              initialValue: form.companionName ?? '',
              decoration: InputDecoration(
                labelText: 'Nombre y apellidos del acompañante *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
                ),
              ),
              onChanged: (value) {
                context.read<RSVPCubit>().updateCompanionName(value);
              },
            ),
          ],
          
          const SizedBox(height: 24),
          
          // Alergias alimentarias
          Text(
            'Alergias alimentarias',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allergies.map((allergy) {
              final isSelected = form.allergies.contains(allergy);
              return FilterChip(
                label: Text(allergy),
                selected: isSelected,
                onSelected: (selected) {
                  context.read<RSVPCubit>().toggleAllergy(allergy);
                },
                selectedColor: Colors.grey.shade200,
              );
            }).toList(),
          ),
          
          // Campo de texto para "otros" alergias
          if (form.allergies.contains('Otros')) ...[
            const SizedBox(height: 24),
            TextFormField(
              initialValue: form.otherAllergies ?? '',
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Especifica tus alergias',
                hintText: 'Describe tus alergias alimentarias...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
                ),
              ),
              onChanged: (value) {
                context.read<RSVPCubit>().updateOtherAllergies(value);
              },
            ),
          ],
          
          const SizedBox(height: 24),
          
          // ¿Necesitarás autobús?
          Text(
            '¿Necesitarás autobús?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: WeddingColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ChoiceChip(
                  label: const Text('Sí'),
                  selected: form.needsBus,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateNeedsBus(selected);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
              const SizedBox(width: 16),
             ChoiceChip(
                  label: const Text('No'),
                  selected: !form.needsBus,
                  onSelected: (selected) {
                    context.read<RSVPCubit>().updateNeedsBus(!selected);
                  },
                  selectedColor: WeddingColors.chipSelected,
                ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Botón de envío
          ElevatedButton(
            onPressed: () {
              context.read<RSVPCubit>().submitForm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: WeddingColors.buttonPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.hovered)) {
                    return WeddingColors.buttonPrimaryHover;
                  }
                  return null;
                },
              ),
            ),
            child: const Text(
              'Confirmar asistencia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }
}

