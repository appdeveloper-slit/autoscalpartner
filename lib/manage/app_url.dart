class AppUrl {
  static String mainUrl = "https://autoscal.in/api/";
  static String policyUrl = "https://autoscal.in/privacy.php";
  static String refundPolicyUrl = "https://autoscal.in/refundpolicy.php";
  static String termsUrl = "https://autoscal.in/terms.php";
}

String sendOTPUrl(){
  return AppUrl.mainUrl + "partner_sendOtp";
}

String resendOTPUrl(){
  return AppUrl.mainUrl + "partner_resendOtp";
}

String verifyOTPUrl(){
  return AppUrl.mainUrl + "partner_verifyOtp";
}

String profileGetUrl(){
  return AppUrl.mainUrl + "get_partner_profile";
}

String partnerOrdersUrl(){
  return AppUrl.mainUrl + "partner_orders";
}

String updateDocumentUrl(){
  return AppUrl.mainUrl + "update_document";
}

String editPartnerProfileUrl(){
  return AppUrl.mainUrl + "edit_partner_profile";
}

String partnerChangeMobileUrl(){
  return AppUrl.mainUrl + "partner_change_mobile";
}

String notificationsUrl(){
  return AppUrl.mainUrl + "get_partner_notification";
}