import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/favorite/domain/repositories/favorite_repository.dart';

class ToggleFavoriteParams extends Equatable {
  const ToggleFavoriteParams({required this.eventId, required this.favorite});

  final String eventId;
  final bool favorite;

  @override
  List<Object?> get props => [eventId, favorite];
}

@lazySingleton
class ToggleFavoriteUseCase implements UseCase<Unit, ToggleFavoriteParams> {
  ToggleFavoriteUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  EitherFailure<Unit> call(ToggleFavoriteParams params) => _repository
      .toggleFavorite(eventId: params.eventId, favorite: params.favorite);
}
