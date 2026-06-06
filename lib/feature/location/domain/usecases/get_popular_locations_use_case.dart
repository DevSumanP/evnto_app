import 'package:injectable/injectable.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/popular_location.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class GetPopularLocationsUseCase
    implements UseCase<List<PopularLocation>, NoParams> {
  GetPopularLocationsUseCase(this._repository);

  final LocationRepository _repository;

  @override
  EitherFailure<List<PopularLocation>> call(final NoParams params) =>
      _repository.getPopularLocations(limit: 10);
}
