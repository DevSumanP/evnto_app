import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

class SaveUserLocationParams extends Equatable {
  const SaveUserLocationParams({required this.city, this.country});

  final String city;
  final String? country;

  @override
  List<Object?> get props => <Object?>[city, country];
}

@lazySingleton
class SaveUserLocationUseCase
    implements UseCase<Unit, SaveUserLocationParams> {
  SaveUserLocationUseCase(this._repository);

  final LocationRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(final SaveUserLocationParams params) =>
      _repository.saveUserLocation(
        UserLocation(city: params.city, country: params.country),
      );
}
