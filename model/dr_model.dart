class DiabeticRetinopathy {
  final String nameDR;
  final String desc;
  final List<String> treatments;

  DiabeticRetinopathy(
      {required this.nameDR, required this.desc, required this.treatments});
}

class NoDR extends DiabeticRetinopathy {
  NoDR({required super.nameDR, required super.desc, required super.treatments});
}

class Mild extends DiabeticRetinopathy {
  Mild({required super.nameDR, required super.desc, required super.treatments});
}

class Moderate extends DiabeticRetinopathy {
  Moderate(
      {required super.nameDR, required super.desc, required super.treatments});
}

class Severe extends DiabeticRetinopathy {
  Severe(
      {required super.nameDR, required super.desc, required super.treatments});
}

class Prolific extends DiabeticRetinopathy {
  Prolific({
    required super.nameDR,
    required super.desc,
    required super.treatments,
  });
}

class DrugProlificDr {
  final String name;
  final String image;
  final String price;

  DrugProlificDr(
      {required this.name, required this.image, required this.price});
}
