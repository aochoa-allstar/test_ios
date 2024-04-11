enum Languages {
  english('en_US', 'languages_en'),
  spanish('es_MX', 'languages_es');

  const Languages(this.localeCode, this.languageString);

  final String localeCode;
  final String languageString;

  dynamic fromId(id) {
    return Languages.values[id];
  }
}
