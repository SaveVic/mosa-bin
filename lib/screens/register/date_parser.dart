class DateParser {
  static final ind2months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static final months2ind = {
    'Januari': 0,
    'Februari': 1,
    'Maret': 2,
    'April': 3,
    'Mei': 4,
    'Juni': 5,
    'Juli': 6,
    'Agustus': 7,
    'September': 8,
    'Oktober': 9,
    'November': 10,
    'Desember': 11,
  };

  static String date2display(DateTime date) {
    String tanggal = date.day.toString();
    String bulan = ind2months[date.month - 1];
    String tahun = date.year.toString();
    return '$tanggal $bulan $tahun';
  }

  static DateTime display2date(String display) {
    List<String> t = display.split(' ');
    int tanggal = int.tryParse(t[0]) ?? 1;
    int bulan = months2ind[t[1]] ?? 0 + 1;
    int tahun = int.tryParse(t[2]) ?? 1900;
    return DateTime(tahun, bulan, tanggal);
  }

  static String saved2display(String saved) {
    List<String> t = saved.split('-');
    int tanggal = int.tryParse(t[2]) ?? 1;
    int bulan = months2ind[t[1]] ?? 0 + 1;
    int tahun = int.tryParse(t[0]) ?? 1900;
    return '$tanggal ${ind2months[bulan - 1]} $tahun';
  }

  static String display2saved(String display) {
    DateTime date = display2date(display);
    String tanggal = date.day.toString().padLeft(2, '0');
    String bulan = ind2months[date.month - 1].padLeft(2, '0');
    String tahun = date.year.toString().padLeft(4, '0');
    return '$tahun-$bulan-$tanggal';
  }

  static bool validateDisplay(String display) {
    List<String> t = display.split(' ');
    if (t.length != 3) return false;

    int tanggal = int.tryParse(t[0]) ?? 40;
    int bulan = months2ind[t[1]] ?? 40;
    int tahun = int.tryParse(t[2]) ?? 2020;
    final date = DateTime(tahun, bulan, tanggal);
    final originalFormatString = toOriginalFormatString(date);
    return '$tahun$bulan$tanggal' == originalFormatString;
  }

  static String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }
}
