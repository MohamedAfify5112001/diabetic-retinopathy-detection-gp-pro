import 'package:no_dr_detection_app/model/dr_model.dart';

List<String> get _treatmentMildModerateSevere => [
      'Fluorescein angiography',
      'Optical coherence tomography (OCT)',
    ];

List<String> get _treatmentProlific => [
      'Vitrectomy',
      'Photocoagulation (laser treatment or focal laser treatment)',
      'Pan retinal photocoagulation',
      'Injecting medications into the eye',
    ];

List<DrugProlificDr> get drugsProlific => [
      DrugProlificDr(
          name: 'Eylea 40mg solution',
          image: 'assets/images/drug1.png',
          price: '8260 L.E'),
      DrugProlificDr(
          name: 'Lucentis 10mg/ml Vial',
          image: 'assets/images/drug2.png',
          price: '5600 L.E'),
      DrugProlificDr(name: 'none', image: 'none', price: 'none'),
    ];

List<String> get _treatmentNoDR => [
      'Monitor your blood sugar level',
      'Ask your doctor about a glycosylated hemoglobin test',
      'Keep your blood pressure and cholesterol under control',
      'If you smoke or use other types of tobacco, ask your doctor to help you quit',
      'Pay attention to vision changes'
    ];

extension DRType on String {
  DiabeticRetinopathy get typeDr {
    switch (this) {
      case "Mild":
        return Mild(
            nameDR: "Mild",
            desc:
                "Patients will experience balloon-like swelling in certain areas of the blood vessels in the retina called microaneurysms.level of Risk: It’s rarely affecting vision.",
            treatments: _treatmentMildModerateSevere);
      case "Moderate":
        return Moderate(
            nameDR: "Moderate",
            desc:
                "Damage to some of the blood vessels in the retina where there is leakage of blood and fluid into the retina tissue. Level of Risk: Thisfluid can cause a loss of vision.",
            treatments: _treatmentMildModerateSevere);
      case "Severe":
        return Severe(
            nameDR: "Severe",
            desc:
                "If there is inadequate control of your diabetes, more blood vessels are blocked with even more leakage of blood and fluid into the retina and the resulting much greater impact on vision. Risk: The lost vision can be improved with appropriate treatment",
            treatments: _treatmentMildModerateSevere);
      case "Prolific":
        return Prolific(
          nameDR: "Prolific",
          desc:
              "Damage to the eye’s normal blood vessels as there is poor circulation inside the eye. The retina then grows new blood vessels; however, they are abnormal and can lead to vision loss and blindness.Risk: The disease is very threatening to one’s vision and may cause loss and blindness",
          treatments: _treatmentProlific,
        );
      default:
        return NoDR(
            nameDR: "No DR",
            desc: "No Diabetic Retinopathy infection.",
            treatments: _treatmentNoDR);
    }
  }
}
