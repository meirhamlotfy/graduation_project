import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../app/utils/consts.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/navigation_helper.dart';
import '../../data/models/stripe_models/create_customer_model/create_customer_model.dart';
import '../../data/models/stripe_models/ephemeral_keys_model/ephemeral_keys_Model.dart';
import '../../data/models/stripe_models/intent_output_model/intent_output_model.dart';
import '../../domain/use_cases/create_customer_use_case.dart';
import '../../domain/use_cases/create_payment_use_case.dart';
import '../../domain/use_cases/ephemeral_key_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);

  IntentOutputModel ? intentOutputModel ;
  CreateCustomerModel ? createCustomerModel;
  EphemeralKeysModel ? ephemeralKeysModel;

bool isOpen = false;

void change(){
  isOpen = true;
  emit(ChatInitial());
}
  Future<void> createPaymentIntent({
    required int amount,
    required String currencyCode,
  }) async{
    emit(ChatLoading());
    final response = await getIt<CreatePaymentIntentUseCase>()(
      CreatePaymentIntentUseCaseParams(
          amount: amount,
          currency:currencyCode,
          customerId: kCustomerId
      ),
    );
    response.fold(
      errorStateHandler,
          (r)async{
        intentOutputModel = r;
        print("intentOutputModel");
        await getEphemeralKeys().then((value){});
        await initSheet(clientSecret: intentOutputModel!.clientSecret!, ephemeralKey: ephemeralKeysModel!.secret!).then((value){});
        await presentSheet();
      },
    );
    emit(ChatInitial());
  }

  Future<void> initSheet({required String clientSecret , required String ephemeralKey})async{
    emit(ChatLoading());
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        //todo add customer Id here
        customerId: kCustomerId,
        customerEphemeralKeySecret:ephemeralKey ,
        merchantDisplayName: "Eng Mohamed",
      ),
    );
    emit(ChatInitial());
  }

  Future<void> presentSheet()async{
    emit(ChatLoading());
    await Stripe.instance.presentPaymentSheet();
    emit(ChatInitial());
  }

  Future<void> getEphemeralKeys()async{
    emit(ChatLoading());
    final response = await getIt<EphemeralKeyUseCase>()(
      EphemeralKeyUseCaseParams(
          customerId: kCustomerId
      ),
    );
    response.fold(
      errorStateHandler,
          (r)async {
        ephemeralKeysModel = r;
        print("ephemeralKeysModel");
        print(" ephemeralKeysModel ${ephemeralKeysModel?.secret??"No Id"}");
      },
    );
    emit(ChatInitial());
  }


//todo call it when userRegister and handel customerId
  void createCustomer()async{
    emit(ChatLoading());
    final response = await getIt<CreateCustomerUseCase>()(
      CreateCustomerUseCaseParams(
        name:  "Eng Mohamed Khalid",
        email: "mohamedKhalid@gmail.com",
        phone: "01009893693",
      ),
    );
    response.fold(
      errorStateHandler,
          (r) {
        createCustomerModel = r;
        print("=================");
        print(" createCustomerModel${createCustomerModel?.id??"No Id"}");
      },
    );
    emit(ChatInitial());
  }
}
