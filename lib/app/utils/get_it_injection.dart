import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/auth_feature/data/data_source/auth_remote_data-source.dart';
import 'package:graduation_project/features/auth_feature/data/repo_impl/auth_repo_impl.dart';
import 'package:graduation_project/features/auth_feature/domain/repo/auth_repo.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/eng_use_cases/eng_login_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/eng_use_cases/eng_register_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/eng_use_cases/get_all_eng_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/farmer_use_cases/farmer_login_use-case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/farmer_use_cases/farmer_register_use_case.dart';
import 'package:graduation_project/features/categories_feature/data/data_source/category_remote_data_source.dart';
import 'package:graduation_project/features/categories_feature/data/repo_impl/category_repo_impl.dart';
import 'package:graduation_project/features/categories_feature/domain/repo/category_repo.dart';
import 'package:graduation_project/features/categories_feature/domain/use_cases/get_all_categories_use_case.dart';
import 'package:graduation_project/features/categories_feature/domain/use_cases/get_all_sub_category_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth_feature/domain/use_casses/farmer_use_cases/get_all_farmers-use_case.dart';
import '../../features/chat_feature/data/data_sources/payment_remote_data_source.dart';
import '../../features/chat_feature/data/repo_impl/payment_repo_impl.dart';
import '../../features/chat_feature/domain/repo/payment_repo.dart';
import '../../features/chat_feature/domain/use_cases/create_customer_use_case.dart';
import '../../features/chat_feature/domain/use_cases/create_payment_use_case.dart';
import '../../features/chat_feature/domain/use_cases/ephemeral_key_use_case.dart';
import '../network/network_info.dart';
import '../network/network_manager.dart';
import '../services/cache_service.dart';
import 'navigation_helper.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // data sources
   getIt.registerLazySingleton<PaymentRemoteDataSource>(() => PaymentRemoteDataSourceImpl());
   getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(networkManager: getIt()));
   getIt.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<EventsRemoteDataSource>(() => EventsRemoteDataSourceImpl(networkManager: getIt()),);

  //* Repository
  getIt.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl(paymentRemoteDataSource: getIt(), networkInfo: getIt()),);
  getIt.registerLazySingleton<AuthRepo>(() => FarmerRepoImpl(farmerRemoteDataSource: getIt(), networkInfo: getIt()),);
  getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl( networkInfo: getIt(), categoryRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<EventsRepo>(() => EventsRepoImpl( networkInfo: getIt(), eventsRemoteDataSource: getIt()),);

  //* Use cases
  _authUseCases();
  _categoryUseCases();
  _homeUseCase();
  _searchUseCase();
  _notificationsUseCases();
  _paymentUseCases();


  //! ----------- app -----------
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  getIt.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  // getIt.registerLazySingleton<FirebaseNotificationService>(() => FirebaseNotificationService(),);
  // getIt.registerLazySingleton<FlutterLocalNotificationService>(() => FlutterLocalNotificationService(),);
  getIt.registerSingleton<NavHelper>(NavHelper());
  getIt.registerSingleton<CacheService>(CacheService());
}

void _authUseCases() {
   getIt.registerLazySingleton<FarmerLoginUseCase>(() => FarmerLoginUseCase(farmerRepo: getIt()));
   getIt.registerLazySingleton<FarmerRegisterUseCase>(() => FarmerRegisterUseCase(farmerRepo: getIt()));
   getIt.registerLazySingleton<GetAllFarmersUseCase>(() => GetAllFarmersUseCase(farmerRepo: getIt()));
   getIt.registerLazySingleton<GetAllEngUseCase>(() => GetAllEngUseCase(farmerRepo: getIt()));
   getIt.registerLazySingleton<EngRegisterUseCase>(() => EngRegisterUseCase(farmerRepo: getIt()));
   getIt.registerLazySingleton<EngLoginUseCase>(() => EngLoginUseCase(farmerRepo: getIt()));
}


void _categoryUseCases() {
  getIt.registerLazySingleton<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCase(categoryRepo: getIt()));
  getIt.registerLazySingleton<GetAllSubCategoriesUseCase>(() => GetAllSubCategoriesUseCase(categoryRepo: getIt()));
}

void _homeUseCase(){
  // getIt.registerLazySingleton<GetHomeDataUseCase>(() => GetHomeDataUseCase(repository: getIt()));
}
void _searchUseCase(){
  // getIt.registerLazySingleton<SearchProductsUseCase>(() => SearchProductsUseCase(repository: getIt()));
}

void _notificationsUseCases() {

}

void _paymentUseCases() {
  getIt.registerLazySingleton<CreateCustomerUseCase>(() => CreateCustomerUseCase(paymentRepo: getIt()));
  getIt.registerLazySingleton<CreatePaymentIntentUseCase>(() => CreatePaymentIntentUseCase(paymentRepo: getIt()));
  getIt.registerLazySingleton<EphemeralKeyUseCase>(() => EphemeralKeyUseCase(paymentRepo: getIt()));
}