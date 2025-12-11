import 'package:wedding_web/data/datasources/rsvp_datasource.dart';
import 'package:wedding_web/models/rsvp_form.dart';

class RSVPRepository {
  final RSVPDataSource dataSource;

  RSVPRepository({required this.dataSource});

  Future<void> submitRSVP(RSVPForm form) async {
    try {
      await dataSource.submitRSVP(form.toJson());
    } catch (e) {
      rethrow;
    }
  }
}

