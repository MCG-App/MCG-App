enum Group {
  class7a('7a', 7),
  class7b('7b', 7),
  class7c('7c', 7),
  class7d('7d', 7),
  class7e('7e', 7),
  class7f('7f', 7),
  class8a('8a', 8),
  class8b('8b', 8),
  class8c('8c', 8),
  class8d('8d', 8),
  class8e('8e', 8),
  class9a('9a', 9),
  class9b('9b', 9),
  class9c('9c', 9),
  class9d('9d', 9),
  class10a('10a', 10),
  class10b('10b', 10),
  class10c('10c', 10),
  class10d('10d', 10),
  class11_1('11-1', 11),
  class11_2('11-2', 11),
  class11_3('11-3', 11),
  class11_4('11-4', 11),
  class11_5('11-5', 11),
  class12_1('12-1', 12),
  class12_2('12-2', 12),
  class12_3('12-3', 12),
  class12_4('12-4', 12),
  class12_5('12-5', 12);

  const Group(this.name, this.level);
  final String name;
  final int level;

  static Group fromName(String name) {
    return Group.values.firstWhere((e) => e.name == name);
  }
}