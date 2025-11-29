  import '../../../../core/network/api_client.dart';
  import '../model/menu_model.dart';


  abstract class MenuRemoteDataSource {
    Future<List<MenuModel>> getMenu();
  }


  class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
    final ApiClient apiClient;

    MenuRemoteDataSourceImpl(this.apiClient);

    @override
    Future<List<MenuModel>> getMenu() async {

      final response = await apiClient.post(
        "https://216.65.200.215/api/auth/menu",
        {
          "MenuType": 1,
          "Defaults": {
            "CurrencyId": 24,
            "CashierId": 1,
            "PlaceId": 1,
            "YearId": 1403,
            "LanguageId": 2,
            "ManagementAccountId": 1
          }
        },
      );

      print("🟣 REMOTE RESPONSE => $response");

      // بررسی نتیجه سرور قبل از تبدیل
      if (response['Result'] != null && response['Result'] == 'Failed') {
        final errorMsg = response['Error'] ?? 'Unknown server error';
        throw Exception(errorMsg); // خطای سرور را پرتاب کن
      }

      final data = response['Data'] as List?;
      if (response['Result'] != null && response['Result'] == 'Failed') {
        final errorMsg = response['Error'] ?? 'Unknown server error';
        throw Exception(errorMsg);
      }
      return data?.map((e) => MenuModel.fromJson(e)).toList() ?? [];

    }
  }
