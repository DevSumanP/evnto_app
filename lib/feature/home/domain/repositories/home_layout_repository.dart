import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/home/domain/entities/home_layout.dart';
import 'package:tap_app/feature/home/domain/entities/home_signals.dart';

abstract class HomeLayoutRepository {
  EitherFailure<HomeLayout> getHomeLayout(HomeSignals signals);
}
