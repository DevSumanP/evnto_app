import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/feature/home/data/datasources/home_layout_remote_data_source.dart';
import 'package:tap_app/feature/home/data/models/home_layout_model.dart';
import 'package:tap_app/feature/home/domain/entities/home_layout.dart';
import 'package:tap_app/feature/home/domain/entities/home_signals.dart';

import '../../domain/repositories/home_layout_repository.dart';

@LazySingleton(as: HomeLayoutRepository)
class HomeLayoutRepositoryImpl extends BaseRepository
    implements HomeLayoutRepository {
  HomeLayoutRepositoryImpl(this._remote);

  final HomeLayoutRemoteDataSource _remote;

  @override
  EitherFailure<HomeLayout> getHomeLayout(HomeSignals signals) => execute(
    operation: () async {
      final Map<String, dynamic> json = await _remote.getHomeLayout(signals);
      return HomeLayoutModel.parse(json);
    },
  );
}
