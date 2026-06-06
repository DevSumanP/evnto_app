import 'package:injectable/injectable.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class ResolveCurrentLocationUseCase implements UseCase<UserLocation, NoParams> {
  ResolveCurrentLocationUseCase(this._repository);

  final LocationRepository _repository;

  @override
  EitherFailure<UserLocation> call(final NoParams params) =>
      _repository.resolveCurrentLocation();
}
