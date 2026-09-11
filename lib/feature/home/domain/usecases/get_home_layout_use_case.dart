import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/home/domain/entities/home_layout.dart';
import 'package:tap_app/feature/home/domain/entities/home_signals.dart';
import 'package:tap_app/feature/home/domain/repositories/home_layout_repository.dart';

@lazySingleton
class GetHomeLayoutUseCase implements UseCase<HomeLayout, HomeSignals> {
  GetHomeLayoutUseCase(this._repository);

  final HomeLayoutRepository _repository;

  @override
  EitherFailure<HomeLayout> call(final HomeSignals params) =>
      _repository.getHomeLayout(params);
}
