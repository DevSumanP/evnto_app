// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../feature/auth/data/datasources/auth_remote_data_source.dart'
    as _i794;
import '../../feature/auth/data/repositories/auth_repository_impl.dart'
    as _i263;
import '../../feature/auth/domain/repositories/auth_repository.dart' as _i488;
import '../../feature/auth/domain/usecases/change_password_use_case.dart'
    as _i849;
import '../../feature/auth/domain/usecases/get_current_user_use_case.dart'
    as _i849;
import '../../feature/auth/domain/usecases/login_use_case.dart' as _i398;
import '../../feature/auth/domain/usecases/logout_use_case.dart' as _i273;
import '../../feature/auth/domain/usecases/signup_use_case.dart' as _i633;
import '../../feature/auth/presentation/blocs/login_bloc.dart' as _i641;
import '../../feature/auth/presentation/blocs/signup_bloc.dart' as _i54;
import '../../feature/checkout/data/datasources/checkout_remote_data_source.dart'
    as _i414;
import '../../feature/checkout/data/repositories/checkout_repository_impl.dart'
    as _i41;
import '../../feature/checkout/domain/repositories/checkout_repository.dart'
    as _i398;
import '../../feature/checkout/domain/usecases/initiate_checkout_use_case.dart'
    as _i298;
import '../../feature/checkout/domain/usecases/verify_checkout_use_case.dart'
    as _i352;
import '../../feature/checkout/presentation/blocs/checkout_bloc.dart' as _i325;
import '../../feature/checkout/presentation/blocs/get_ticket_bloc.dart'
    as _i199;
import '../../feature/event-detail/data/datasources/event_detail_remote_data_Source.dart'
    as _i988;
import '../../feature/event-detail/data/repositories/event_detail_repository_impl.dart'
    as _i130;
import '../../feature/event-detail/domain/repositories/event_detail_repository.dart'
    as _i949;
import '../../feature/event-detail/domain/usecases/get_event_detail_usecase.dart'
    as _i570;
import '../../feature/event-detail/presentation/blocs/event_detail_bloc.dart'
    as _i725;
import '../../feature/explore/data/datasources/explore_remote_data_source.dart'
    as _i867;
import '../../feature/explore/data/datasources/recent_searches_store.dart'
    as _i407;
import '../../feature/explore/data/repositories/explore_repository_impl.dart'
    as _i441;
import '../../feature/explore/domain/repositories/explore_repository.dart'
    as _i827;
import '../../feature/explore/domain/usecases/get_nearby_events_use_case.dart'
    as _i886;
import '../../feature/explore/domain/usecases/search_events_use_case.dart'
    as _i333;
import '../../feature/explore/presentation/blocs/explore_bloc.dart' as _i482;
import '../../feature/favorite/data/datasources/favorite_remote_data_source.dart'
    as _i143;
import '../../feature/favorite/data/repositories/favorite_repository_impl.dart'
    as _i222;
import '../../feature/favorite/domain/repositories/favorite_repository.dart'
    as _i815;
import '../../feature/favorite/domain/usecases/get_favorite_use_case.dart'
    as _i1020;
import '../../feature/favorite/domain/usecases/toggle_favorite_use_case.dart'
    as _i443;
import '../../feature/favorite/presentation/blocs/favorites_cubit.dart'
    as _i1050;
import '../../feature/favorite/presentation/blocs/favorites_list_cubit.dart'
    as _i973;
import '../../feature/home/data/datasources/home_remote_data_source.dart'
    as _i832;
import '../../feature/home/data/repositories/home_repository_impl.dart'
    as _i746;
import '../../feature/home/domain/repositories/home_repository.dart' as _i42;
import '../../feature/home/domain/usecases/get_popular_event_use_case.dart'
    as _i806;
import '../../feature/home/domain/usecases/get_suggested_event_use_case.dart'
    as _i988;
import '../../feature/home/domain/usecases/get_upcoming_event_use_case.dart'
    as _i560;
import '../../feature/home/presentation/blocs/home_bloc.dart' as _i187;
import '../../feature/location/data/datasources/location_device_data_source.dart'
    as _i796;
import '../../feature/location/data/datasources/location_remote_data_source.dart'
    as _i904;
import '../../feature/location/data/repositories/location_repository_impl.dart'
    as _i335;
import '../../feature/location/domain/repositories/location_repository.dart'
    as _i924;
import '../../feature/location/domain/usecases/get_popular_locations_use_case.dart'
    as _i813;
import '../../feature/location/domain/usecases/resolve_current_location_use_case.dart'
    as _i463;
import '../../feature/location/domain/usecases/save_user_location_use_case.dart'
    as _i502;
import '../../feature/location/presentation/blocs/choose_location_bloc.dart'
    as _i669;
import '../../feature/profile/data/datasources/profile_remote_data_source.dart'
    as _i256;
import '../../feature/profile/data/repositories/profile_repository_impl.dart'
    as _i1035;
import '../../feature/profile/domain/repositories/profile_repository.dart'
    as _i173;
import '../../feature/profile/domain/usecases/delete_account_use_case.dart'
    as _i190;
import '../../feature/profile/domain/usecases/get_my_orders_use_case.dart'
    as _i91;
import '../../feature/profile/domain/usecases/get_profile_use_case.dart'
    as _i628;
import '../../feature/profile/domain/usecases/set_notifications_use_case.dart'
    as _i239;
import '../../feature/profile/domain/usecases/update_avatar_use_case.dart'
    as _i147;
import '../../feature/profile/domain/usecases/update_profile_use_case.dart'
    as _i3;
import '../../feature/profile/presentation/blocs/profile_bloc.dart' as _i40;
import '../../feature/profile/presentation/blocs/settings_bloc.dart' as _i512;
import '../../feature/splash/data/datasources/app_status_remote_data_source.dart'
    as _i327;
import '../../feature/splash/data/repositories/app_status_repository_impl.dart'
    as _i912;
import '../../feature/splash/domain/repositories/app_status_repository.dart'
    as _i768;
import '../../feature/splash/domain/usecases/check_app_status_use_case.dart'
    as _i168;
import '../../feature/splash/domain/usecases/check_initial_status_use_case.dart'
    as _i584;
import '../../feature/splash/presentation/blocs/splash_bloc.dart' as _i1020;
import '../../feature/tickets/data/datasources/ticket_remote_data_source.dart'
    as _i745;
import '../../feature/tickets/data/repositories/ticket_repository_impl.dart'
    as _i322;
import '../../feature/tickets/domain/repositories/ticket_repository.dart'
    as _i559;
import '../../feature/tickets/domain/usecases/get_my_ticket_qr_use_case.dart'
    as _i97;
import '../../feature/tickets/domain/usecases/get_my_tickets_use_case.dart'
    as _i75;
import '../../feature/tickets/presentation/blocs/ticket_detail_bloc.dart'
    as _i261;
import '../../feature/tickets/presentation/blocs/tickets_bloc.dart' as _i290;
import '../network/api_client.dart' as _i557;
import '../network/network_info.dart' as _i932;
import '../notifications/notification_module.dart' as _i391;
import '../notifications/notification_service.dart' as _i229;
import '../router/app_router.dart' as _i81;
import '../services/analytics/analytics_service.dart' as _i554;
import '../services/analytics/posthog_analytics_service.dart' as _i460;
import '../services/auth_session_service.dart' as _i1028;
import '../services/storage_service.dart' as _i306;
import 'modules/remote_module.dart' as _i616;
import 'modules/service_module.dart' as _i681;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final serviceModule = _$ServiceModule();
    final remoteModule = _$RemoteModule();
    final notificationModule = _$NotificationModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => serviceModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i81.AppRouter>(() => _i81.AppRouter());
    gh.lazySingleton<_i361.Dio>(() => remoteModule.dio);
    gh.lazySingleton<_i557.ApiClient>(() => remoteModule.apiClient);
    gh.lazySingleton<_i932.NetworkInfo>(() => remoteModule.networkInfo);
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => notificationModule.messaging,
    );
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
      () => notificationModule.localNotifications,
    );
    gh.lazySingleton<_i796.LocationDeviceDataSource>(
      () => const _i796.LocationDeviceDataSourceImpl(),
    );
    gh.lazySingleton<_i904.LocationRemoteDataSource>(
      () => _i904.LocationRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i867.ExploreRemoteDataSource>(
      () => _i867.ExploreRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i327.AppStatusRemoteDataSource>(
      () => _i327.AppStatusRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i794.AuthRemoteDataSource>(
      () => _i794.AuthRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i832.HomeRemoteDataSource>(
      () => _i832.HomeRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i229.NotificationService>(
      () => _i229.NotificationService(
        gh<_i892.FirebaseMessaging>(),
        gh<_i163.FlutterLocalNotificationsPlugin>(),
        gh<_i557.ApiClient>(),
      ),
    );
    gh.lazySingleton<_i554.AnalyticsService>(
      () => _i460.PosthogAnalyticsService(),
    );
    gh.lazySingleton<_i988.EventDetailRemoteDataSource>(
      () => _i988.EventDetailRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i827.ExploreRepository>(
      () => _i441.ExploreRepositoryImpl(gh<_i867.ExploreRemoteDataSource>()),
    );
    gh.lazySingleton<_i143.FavoriteRemoteDataSource>(
      () => _i143.FavoriteRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i414.CheckoutRemoteDataSource>(
      () => _i414.CheckoutRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i745.TicketRemoteDataSource>(
      () => _i745.TicketRemoteDataSourceImpl(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i949.EventDetailRepository>(
      () => _i130.EventDetailRepositoryImpl(
        gh<_i988.EventDetailRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i306.StorageService>(
      () => _i306.StorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i570.GetEventDetailUsecase>(
      () => _i570.GetEventDetailUsecase(gh<_i949.EventDetailRepository>()),
    );
    gh.lazySingleton<_i42.HomeRepository>(
      () => _i746.HomeRepositoryImpl(gh<_i832.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i924.LocationRepository>(
      () => _i335.LocationRepositoryImpl(
        gh<_i904.LocationRemoteDataSource>(),
        gh<_i796.LocationDeviceDataSource>(),
        gh<_i306.StorageService>(),
      ),
    );
    gh.lazySingleton<_i559.TicketRepository>(
      () => _i322.TicketRepositoryImpl(gh<_i745.TicketRemoteDataSource>()),
    );
    gh.lazySingleton<_i398.CheckoutRepository>(
      () => _i41.CheckoutRepositoryImpl(gh<_i414.CheckoutRemoteDataSource>()),
    );
    gh.lazySingleton<_i256.ProfileRemoteDataSource>(
      () => _i256.ProfileRemoteDataSourceImpl(
        gh<_i557.ApiClient>(),
        gh<_i892.FirebaseMessaging>(),
      ),
    );
    gh.lazySingleton<_i97.GetTicketQrUseCase>(
      () => _i97.GetTicketQrUseCase(gh<_i559.TicketRepository>()),
    );
    gh.lazySingleton<_i768.AppStatusRepository>(
      () =>
          _i912.AppStatusRepositoryImpl(gh<_i327.AppStatusRemoteDataSource>()),
    );
    gh.lazySingleton<_i886.GetNearbyEventsUseCase>(
      () => _i886.GetNearbyEventsUseCase(gh<_i827.ExploreRepository>()),
    );
    gh.lazySingleton<_i333.SearchEventsUseCase>(
      () => _i333.SearchEventsUseCase(gh<_i827.ExploreRepository>()),
    );
    gh.lazySingleton<_i168.CheckAppStatusUseCase>(
      () => _i168.CheckAppStatusUseCase(gh<_i768.AppStatusRepository>()),
    );
    gh.factory<_i261.TicketDetailBloc>(
      () => _i261.TicketDetailBloc(gh<_i97.GetTicketQrUseCase>()),
    );
    gh.lazySingleton<_i298.InitiateCheckoutUseCase>(
      () => _i298.InitiateCheckoutUseCase(gh<_i398.CheckoutRepository>()),
    );
    gh.lazySingleton<_i352.VerifyCheckoutUseCase>(
      () => _i352.VerifyCheckoutUseCase(gh<_i398.CheckoutRepository>()),
    );
    gh.lazySingleton<_i815.FavoriteRepository>(
      () => _i222.FavoriteRepositoryImpl(gh<_i143.FavoriteRemoteDataSource>()),
    );
    gh.lazySingleton<_i806.GetPopularEventsUseCase>(
      () => _i806.GetPopularEventsUseCase(gh<_i42.HomeRepository>()),
    );
    gh.lazySingleton<_i988.GetSuggestedEventUseCase>(
      () => _i988.GetSuggestedEventUseCase(gh<_i42.HomeRepository>()),
    );
    gh.lazySingleton<_i560.GetUpcomingEventUseCase>(
      () => _i560.GetUpcomingEventUseCase(gh<_i42.HomeRepository>()),
    );
    gh.lazySingleton<_i1028.AuthSessionService>(
      () => _i1028.AuthSessionService(gh<_i306.StorageService>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i407.RecentSearchesStore>(
      () => _i407.RecentSearchesStore(gh<_i306.StorageService>()),
    );
    gh.lazySingleton<_i813.GetPopularLocationsUseCase>(
      () => _i813.GetPopularLocationsUseCase(gh<_i924.LocationRepository>()),
    );
    gh.lazySingleton<_i463.ResolveCurrentLocationUseCase>(
      () => _i463.ResolveCurrentLocationUseCase(gh<_i924.LocationRepository>()),
    );
    gh.lazySingleton<_i502.SaveUserLocationUseCase>(
      () => _i502.SaveUserLocationUseCase(gh<_i924.LocationRepository>()),
    );
    gh.lazySingleton<_i584.InitializeAppUseCase>(
      () => _i584.InitializeAppUseCase(
        gh<_i168.CheckAppStatusUseCase>(),
        gh<_i306.StorageService>(),
        gh<_i1028.AuthSessionService>(),
      ),
    );
    gh.lazySingleton<_i75.GetMyTicketsUseCase>(
      () => _i75.GetMyTicketsUseCase(gh<_i559.TicketRepository>()),
    );
    gh.factory<_i325.CheckoutBloc>(
      () => _i325.CheckoutBloc(
        gh<_i298.InitiateCheckoutUseCase>(),
        gh<_i352.VerifyCheckoutUseCase>(),
      ),
    );
    gh.factory<_i669.ChooseLocationBloc>(
      () => _i669.ChooseLocationBloc(
        gh<_i813.GetPopularLocationsUseCase>(),
        gh<_i463.ResolveCurrentLocationUseCase>(),
        gh<_i502.SaveUserLocationUseCase>(),
      ),
    );
    gh.factory<_i290.TicketsBloc>(
      () => _i290.TicketsBloc(gh<_i75.GetMyTicketsUseCase>()),
    );
    gh.lazySingleton<_i488.AuthRepository>(
      () => _i263.AuthRepositoryImpl(
        gh<_i794.AuthRemoteDataSource>(),
        gh<_i1028.AuthSessionService>(),
      ),
    );
    gh.lazySingleton<_i849.ChangePasswordUseCase>(
      () => _i849.ChangePasswordUseCase(gh<_i488.AuthRepository>()),
    );
    gh.lazySingleton<_i398.LoginUseCase>(
      () => _i398.LoginUseCase(gh<_i488.AuthRepository>()),
    );
    gh.lazySingleton<_i273.LogoutUseCase>(
      () => _i273.LogoutUseCase(gh<_i488.AuthRepository>()),
    );
    gh.lazySingleton<_i633.SignUpUseCase>(
      () => _i633.SignUpUseCase(gh<_i488.AuthRepository>()),
    );
    gh.lazySingleton<_i1020.GetFavoritesUseCase>(
      () => _i1020.GetFavoritesUseCase(gh<_i815.FavoriteRepository>()),
    );
    gh.lazySingleton<_i443.ToggleFavoriteUseCase>(
      () => _i443.ToggleFavoriteUseCase(gh<_i815.FavoriteRepository>()),
    );
    gh.factory<_i1020.SplashBloc>(
      () => _i1020.SplashBloc(gh<_i584.InitializeAppUseCase>()),
    );
    gh.factory<_i641.LoginBloc>(
      () => _i641.LoginBloc(gh<_i398.LoginUseCase>()),
    );
    gh.lazySingleton<_i849.GetCurrentUserUseCase>(
      () => _i849.GetCurrentUserUseCase(gh<_i488.AuthRepository>()),
    );
    gh.factory<_i54.SignupBloc>(
      () => _i54.SignupBloc(gh<_i633.SignUpUseCase>()),
    );
    gh.lazySingleton<_i1050.FavoritesCubit>(
      () => _i1050.FavoritesCubit(
        gh<_i1020.GetFavoritesUseCase>(),
        gh<_i443.ToggleFavoriteUseCase>(),
        gh<_i1028.AuthSessionService>(),
      ),
    );
    gh.factory<_i725.EventDetailBloc>(
      () => _i725.EventDetailBloc(
        gh<_i570.GetEventDetailUsecase>(),
        gh<_i1050.FavoritesCubit>(),
      ),
    );
    gh.factory<_i199.GetTicketBloc>(
      () => _i199.GetTicketBloc(gh<_i849.GetCurrentUserUseCase>()),
    );
    gh.factory<_i973.FavoritesListCubit>(
      () => _i973.FavoritesListCubit(
        gh<_i1020.GetFavoritesUseCase>(),
        gh<_i1050.FavoritesCubit>(),
      ),
    );
    gh.lazySingleton<_i173.ProfileRepository>(
      () => _i1035.ProfileRepositoryImpl(
        gh<_i256.ProfileRemoteDataSource>(),
        gh<_i849.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i482.ExploreBloc>(
      () => _i482.ExploreBloc(
        gh<_i333.SearchEventsUseCase>(),
        gh<_i886.GetNearbyEventsUseCase>(),
        gh<_i407.RecentSearchesStore>(),
        gh<_i1050.FavoritesCubit>(),
      ),
    );
    gh.factory<_i187.HomeBloc>(
      () => _i187.HomeBloc(
        gh<_i560.GetUpcomingEventUseCase>(),
        gh<_i806.GetPopularEventsUseCase>(),
        gh<_i988.GetSuggestedEventUseCase>(),
        gh<_i306.StorageService>(),
        gh<_i1050.FavoritesCubit>(),
      ),
    );
    gh.lazySingleton<_i190.DeleteAccountUseCase>(
      () => _i190.DeleteAccountUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.lazySingleton<_i91.UpdateProfileUseCase>(
      () => _i91.UpdateProfileUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.lazySingleton<_i628.GetProfileUseCase>(
      () => _i628.GetProfileUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.lazySingleton<_i239.SetNotificationsUseCase>(
      () => _i239.SetNotificationsUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.lazySingleton<_i147.UpdateAvatarUseCase>(
      () => _i147.UpdateAvatarUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.lazySingleton<_i3.UpdateProfileUseCase>(
      () => _i3.UpdateProfileUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.factory<_i512.SettingsBloc>(
      () => _i512.SettingsBloc(
        gh<_i239.SetNotificationsUseCase>(),
        gh<_i306.StorageService>(),
      ),
    );
    gh.factory<_i40.ProfileBloc>(
      () => _i40.ProfileBloc(
        gh<_i628.GetProfileUseCase>(),
        gh<_i3.UpdateProfileUseCase>(),
        gh<_i849.ChangePasswordUseCase>(),
        gh<_i147.UpdateAvatarUseCase>(),
      ),
    );
    return this;
  }
}

class _$ServiceModule extends _i681.ServiceModule {}

class _$RemoteModule extends _i616.RemoteModule {}

class _$NotificationModule extends _i391.NotificationModule {}
