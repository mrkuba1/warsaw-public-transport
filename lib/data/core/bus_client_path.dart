enum BusClientPath {
  busstopsline,
  timetables;

  const BusClientPath();

  String get path {
    switch (this) {
      case BusClientPath.busstopsline:
        return 'get_ztm_lista_linii_na_przystanku';
      case BusClientPath.timetables:
        return 'get_ztm_odjazdy_linii_z_przystanku';
    }
  }

  Uri get baseUri => Uri.https('dane.um.warszawa.pl', '/api/action/$path');
}
