class ApiConstants {
  static const String baseUrl =
      "https://mehtag-eh-production-1dea.up.railway.app/api/";

  static const String login = "auth/login";
  static const String createAdmin = "admin/create-admin";

  static const String requesterEndPoint = "needies";
  static const String donorEndPoint = "donors";
  static const String donations = '/donations/add';

  static const String requests = "requests";
  static const String approvedRequests = "requests/approved";

  static String needyRequests(String needyId) => "requests/needy/$needyId";
  static String requestById(String id) => 'requests/$id';

  static String sendDonation(String id) => "requests/donor/send-donation/$id";
  static String confirmReceipt(String id) =>
      "requests/needy/confirm-receipt/$id";
}
