import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint4_fix/app/shared_prefs/token_shared_prefs.dart';
import 'package:sprint4_fix/core/network/api_service.dart';
import 'package:sprint4_fix/core/network/hive_service.dart';
import 'package:sprint4_fix/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:sprint4_fix/features/auth/data/data_source/auth_remote_datasource.dart/auth_remote_datasource.dart';
import 'package:sprint4_fix/features/auth/data/repository/auth_local_repository.dart';
import 'package:sprint4_fix/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:sprint4_fix/features/auth/domain/use_case/login_usecase.dart';
import 'package:sprint4_fix/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:sprint4_fix/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:sprint4_fix/features/home/data/datasource/home_remote_datasource.dart';
import 'package:sprint4_fix/features/home/data/repository/appointment_repository_impl.dart';
import 'package:sprint4_fix/features/home/domain/repository/appointment_repository.dart';
import 'package:sprint4_fix/features/home/domain/repository/get_accelerometer_data.dart';
import 'package:sprint4_fix/features/home/domain/usecase/add_appointment.dart';
import 'package:sprint4_fix/features/home/domain/usecase/get_appointments.dart';
import 'package:sprint4_fix/features/home/domain/usecase/get_gyroscope_data.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/home_cubit.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/map_bloc/map_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_bloc.dart';
import 'package:sprint4_fix/features/splash/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initSplashDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initMapDependencies();
  await _initSettingsDependencies();
  await _initTermsDependencies();
  await _initAboutDependencies();
  await _initBookingDependencies();
  await _initNavbarDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

Future<void> _initApiService() async {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

Future<void> _initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

// Splash Dependencies
Future<void> _initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
}

// Register Dependencies
Future<void> _initRegisterDependencies() async {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(getIt<AuthRemoteRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUseCase: getIt<UploadImageUsecase>(),
    ),
  );
}

// Home Dependencies
Future<void> _initHomeDependencies() async {
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<GetGyroscopeData>(() => GetGyroscopeData());
  getIt.registerLazySingleton<GetAccelerometerData>(
      () => GetAccelerometerData());
  getIt.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl());
  getIt.registerLazySingleton<GetAppointments>(
      () => GetAppointments(getIt<AppointmentRepository>()));
  getIt.registerLazySingleton<AddAppointment>(
      () => AddAppointment(getIt<AppointmentRepository>()));
}

// Login Dependencies
Future<void> _initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// Map Dependencies
Future<void> _initMapDependencies() async {
  getIt.registerLazySingleton<MapBloc>(() => MapBloc());
}

// Settings Dependencies
Future<void> _initSettingsDependencies() async {
  getIt.registerFactory<SettingsBloc>(
      () => SettingsBloc(getIt<HomeRemoteDataSource>()));
}

// Terms Dependencies
Future<void> _initTermsDependencies() async {
  getIt.registerLazySingleton<TermsBloc>(() => TermsBloc());
}

// About Dependencies
Future<void> _initAboutDependencies() async {
  getIt.registerLazySingleton<AboutBloc>(() => AboutBloc());
}

// Booking Dependencies
Future<void> _initBookingDependencies() async {
  getIt.registerFactory<BookingBloc>(
    () => BookingBloc(
      getAppointments: getIt<GetAppointments>(),
      addAppointment: getIt<AddAppointment>(),
    ),
  );
}

// Navbar Dependencies
Future<void> _initNavbarDependencies() async {
  getIt.registerFactory<NavbarBlocBloc>(
    () => NavbarBlocBloc(
      getIt<GetGyroscopeData>(),
      getIt<GetAccelerometerData>(),
    ),
  );
}
