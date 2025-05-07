import 'package:flutter/material.dart';

class MatchHelper {
  static String getProductName(String slug) {
    switch (slug) {
      case 'adult_unit_red_blood':
        return 'Culot globulaire adulte';
      case 'children_unit_red_blood':
        return 'Culot globulaire enfant';
      case 'standard_platelet_concentrate':
        return 'Concentrés de standards de plaquettes';
      case 'fresh_frozen_plasma':
        return 'Plasma frais congelé';
      default:
        return '';
    }
  }

  static String getText(pslRequest) {
    switch (pslRequest.status) {
      case "found":
        return "Trouvé";
      case "not_found":
        return "Non trouvé";
      case "waiting_payment":
        return "En attente de paiement";
      case "paid":
        return "Payé";
      default:
        return "En attente";
    }
  }

  static String getButtonText(pslRequest) {
    switch (pslRequest.status) {
      case "found":
        return "Payer ma demande";
      case "not_found":
        return "Revérifier";
      case "waiting_payment":
        return "Payer ma demande";
      default:
        return "";
    }
  }

  static Color getColor(pslRequest) {
    switch (pslRequest.status) {
      case "found":
        return Colors.blue;
      case "not_found":
        return Colors.red;
      case "waiting_payment":
        return Colors.orange;
      case "paid":
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
