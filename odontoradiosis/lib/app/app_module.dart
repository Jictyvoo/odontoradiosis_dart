import 'package:flutter_modular/flutter_modular.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import '../core/infra/repositories/image_repository_impl.dart';
import 'modules/lateral_radiography/radiography_page.dart';
import 'shared/app_routes.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<ImageRepository>((i) => ImageRepositoryImpl()),
        Bind.factory<LateralCephalometricService>(
          (i) => LateralCephalometricService(i<ImageRepository>()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute<LateralRadiographyPage>(
          AppRoutes.DEFAULT.route,
          child: (context, args) => const LateralRadiographyPage(
            title: 'Odontoradiosis',
          ),
        ),
      ];
}
