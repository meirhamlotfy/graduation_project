
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

const String kBaseUrl = "smart-farm-seven.vercel.app";
const String kBaseVersion = '';

// end points
const String kSignIn = 'auth/user/login';
const String kSignUp = 'auth/register';
const String kSocialLogin = 'auth/social-login';
const String kGetMe = 'auth/user/me';
const String kRefreshToken = 'auth/user/refresh';
const String kSignOut = 'auth/user/logout';
const String kResetPassword = 'auth/reset-password';
const String kForgetVerifyOtp = 'auth/forget-password/verify-otp';
const String kForgetPassword = 'auth/forget-password';
const String kVerifyOtp = 'auth/verify-otp';
const String kResendOtp = 'auth/resend-otp';
const String kGetEvents = 'event';



const String kActivateAccount = 'activate';
const String kChangePassword = 'update-passward';
const String kNotifications = 'notifications';
const String kNotificationsCount = 'count-notifications';
const String kDeleteAccount = 'delete-account';
const String kUserHome = 'home';
const String kProductDetails = 'product';
const String kProfile = 'profile';
const String kUpdateProfile = 'update-profile';
const String kContactUs = 'contact-us';
const String kChangeLanguage = 'change-lang';
const String kUpdatePassword = 'update-passward';
const String kListCommodities = 'commodities';
const String kAddItemToCart = 'cart/add';
const String kCarts = 'cart/list';
const String kUpdateQuantity = 'cart/update';
const String kRemoveItemFromCartCart = 'cart';
const String kSaveItemForLater = 'cart/save-for-later';
const String kAddItemToFavourite = 'favourites/add';
const String kFavourite = 'favourites/list';
const String kFavouritesUpdateQuantity = 'favourites/update';
const String kRemoveItemFromFavourites = 'favourites';
const String kSaveItemToCart = 'favourites/move-to-cart';
const String kListAllCategories = 'list-categories';
const String kListAllBestSelling = 'all-best-selling';
const String kListAllBestOffers = 'all-best-offer';
const String kListAllNewCollections= 'all-new-collection';
const String kCategoryProducts= 'product-with-category';
const String kSearchProduct= 'search-product';
const String kCheckout= 'orders/check-out';
const String kCheckCoupon= 'orders/check-coupon';
const String kPlaceOrder= 'orders/place';
const String kPInProgressOrder= 'orders/in-progress';
const String kShippingOrder= 'orders/shipping';
const String kDeliveredOrder= 'orders/delivered';
const String kCancelledOrder= 'orders/canceled';
const String kOrderDetails= 'orders';
const String kCancelOrderItem= 'orders/cancel';
const String kReviewOrderItem= 'orders/review-product';
const String kGetAddresses= 'shipping-address/index';
const String kAddAddress= 'shipping-address/create';
const String kEditAddress= 'shipping-address/edit';
const String kDeleteAddress= 'shipping-address';



const String kAlertDialogue= 'انت مش مسجل حساب , عايز تسجل ؟';
const String kAlertCancelButtonText= 'انت مش مسجل حساب , عايز تسجل ؟';
const String kAlertOkButtonText= 'انت مش مسجل حساب , عايز تسجل ؟';

//Static Headers
 Map<String, String> apiHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json, text/plain, */*",
  "X-Requested-With": "XMLHttpRequest",
  "api-key": "kiOl6bPMfKCajXiUBUZ72IFPceFcDmgRDgBeaMJ9n3H2S1m6LmnraobtMIYdxxQ6",
};

 // Stripe keys

const String kPublishKey= 'pk_test_51NcYZ1IFBuxSP4IyHk35qI4RSKdmWyWl40XRt6T2SPc9OPo35cwnMJY0um0DwCChfDfyMD9Hiq7Ecn8PRttdrHP100XAw4bhFL';
const String kSecretKey= 'sk_test_51NcYZ1IFBuxSP4IyHPxRBxM7hwSNclM111B2vACftn35lmmhIw1Lyu1A1UkJ4AT08DWRULN37gUyZAXSdRKRnQ2v00hPaFnFsX';
const String kCustomerId = "cus_PcwbeYfJKIRvzA";

Future<void> urlLaunch({required String url}) async {
 if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
  throw Exception('Could not launch $url');
 }
}

Future<void> speak(String text) async {
 await flutterTts.setLanguage(await Devicelocale.currentLocale == "en-US"?"ar-EG":"ar-EG",
 );
 await FlutterTts().setSpeechRate(.3);
 await FlutterTts().setVolume(1.0);
 await FlutterTts().setPitch(.65);
 await FlutterTts().speak(text);
}

