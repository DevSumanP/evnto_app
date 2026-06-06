import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/profile/domain/repositories/profile_repository.dart';

class SetNotificationParams extends Equatable {
  const SetNotificationParams({required this.enabled});
  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}

@lazySingleton
class SetNotificationsUseCase implements UseCase<Unit, SetNotificationParams> {
  SetNotificationsUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  EitherFailure<Unit> call(SetNotificationParams params) =>
      _repository.setNotifications(enabled: params.enabled);
}
