import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

abstract class SupportedCephalometric {
  static const allCurves = 'Todas as Curvas';

  static const clearSelection = 'Selecione';

  static const supportedCurves = [
    TracingCurveDefinition('Perfil Mole'),
    TracingCurveDefinition('Sela Túrcica'),
    TracingCurveDefinition('Sutura Fronto-Nasal'),
    TracingCurveDefinition('Borda Póstero-Inferior'),
    TracingCurveDefinition('Fissura Pterigomaxilar'),
    TracingCurveDefinition('Pório Anatômico'),
    TracingCurveDefinition('Maxila'),
    TracingCurveDefinition('Mandíbula'),
    TracingCurveDefinition('Incisivo Central Superior'),
    TracingCurveDefinition('Incisivo Central Inferior'),
    TracingCurveDefinition('Dente Posterior Superior'),
    TracingCurveDefinition('Dente Posterior Inferior'),
  ];

  static const supportedPoints = [
    LandmarkDefinition('Sela', 'S'),
    LandmarkDefinition('Násio', 'N'),
    LandmarkDefinition('Espinha nasal anterior', 'ENA'),
    LandmarkDefinition('Espinha nasal posterior', 'ENP'),
    LandmarkDefinition('Ponto subespinhal', 'A'),
    LandmarkDefinition('Ponto pupramental', 'B'),
    LandmarkDefinition('Pogônio', 'Pog'),
    LandmarkDefinition('Gnátio', 'Gn'),
    LandmarkDefinition('Mento', 'Me'),
    LandmarkDefinition('Condílio', 'Co'),
    LandmarkDefinition('Pró-nasal', 'Pn'),
    LandmarkDefinition('Pogônio Mole', 'Pg'),
    LandmarkDefinition('Palato Mole', 'pm'),
    LandmarkDefinition('Gônio', 'Go'),
    LandmarkDefinition('Órbitário', 'Or'),
    LandmarkDefinition('Pório', 'Po'),
    LandmarkDefinition('Ponta do Nariz', 'PN'),
    LandmarkDefinition('Fossa Ptérigo Maxilar', 'Fpm'),
    LandmarkDefinition('Pterigóide', 'Pt'),
  ];
}
