import 'package:flutter_aula_1/models/habito.dart';

class Utils {
  static String saudacao() {
    final hora = DateTime.now().hour;
    if (hora < 6) {
      return 'Boa noite';
    } else if (hora < 12) {
      return 'Bom dia';
    } else if (hora < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  static String formatarData(DateTime data) {
    final dias = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    final meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return '${dias[data.weekday % 7]}, ${data.day} ${meses[data.month - 1]} ${data.year}';
  }

  static Map<String, int> calcularProgressoHabitos(List<Habito> habitos) {
    int total = habitos.length;
    int completos = habitos.where((h) => h.isCompletedToday()).length;

    return {'completos': completos, 'total': total};
  }
}
