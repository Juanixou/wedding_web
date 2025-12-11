class RSVPForm {
  final String name;
  final String? companionName;
  final bool hasCompanion;
  final List<String> allergies;
  final String? otherAllergies;
  final bool needsBus;

  RSVPForm({
    required this.name,
    this.companionName,
    this.hasCompanion = false,
    this.allergies = const [],
    this.otherAllergies,
    this.needsBus = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'companionName': companionName,
      'hasCompanion': hasCompanion,
      'allergies': allergies,
      'otherAllergies': otherAllergies,
      'needsBus': needsBus,
    };
  }

  RSVPForm copyWith({
    String? name,
    String? companionName,
    bool? hasCompanion,
    List<String>? allergies,
    String? otherAllergies,
    bool? needsBus,
  }) {
    return RSVPForm(
      name: name ?? this.name,
      companionName: companionName ?? this.companionName,
      hasCompanion: hasCompanion ?? this.hasCompanion,
      allergies: allergies ?? this.allergies,
      otherAllergies: otherAllergies ?? this.otherAllergies,
      needsBus: needsBus ?? this.needsBus,
    );
  }
}

