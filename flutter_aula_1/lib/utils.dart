class Utils {
  static String saudacao() {
    final hora = DateTime.now().hour;
    if (hora < 12) {
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
}
