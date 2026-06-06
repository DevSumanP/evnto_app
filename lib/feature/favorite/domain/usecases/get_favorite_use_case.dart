import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/favorite/domain/repositories/favorite_repository.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

class GetFavoritesParams extends Equatable {
  const GetFavoritesParams({this.page = 1, this.pageSize = 20});

  final int page;
  final int pageSize;

  @override
  List<Object?> get props => <Object?>[page, pageSize];
}

@lazySingleton
class GetFavoritesUseCase implements UseCase<List<Event>, GetFavoritesParams> {
  GetFavoritesUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  EitherFailure<List<Event>> call(final GetFavoritesParams params) =>
      _repository.getFavorites(page: params.page, pageSize: params.pageSize);
}
