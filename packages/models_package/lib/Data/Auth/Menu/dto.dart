import '../../../Base/base_request.dart';

class Request extends BaseRequest {
  int menuType;

  Request({required this.menuType});
}

class Response extends BaseResponse<ResponseData> {
  List<ResponseData> data;

  Response({List<ResponseData>? data})
      : data = data ?? [],
        super();
}

class ResponseData implements ISelectable {
  int? menuId;
  String? menuDesc;
  String? appLink;
  String? webLink;
  int? actionId;
  int? repoId;
  int? systemId;
  String? icon;
  String? iconUrl;

  List<ResponseData> subMenus;
  bool isSelected;

  ResponseData({
    this.menuId,
    this.menuDesc,
    this.appLink,
    this.webLink,
    this.actionId,
    this.repoId,
    this.systemId,
    this.icon,
    this.iconUrl,
    List<ResponseData>? subMenus,
    this.isSelected = false,
  }) : subMenus = subMenus ?? [];
}

// Interface ISelectable
abstract class ISelectable {
  bool get isSelected;
  set isSelected(bool value);
}

// Base classes placeholder
class BaseQueryRequest {
// می‌تونی ویژگی‌های مشترک درخواست‌ها رو اینجا اضافه کنی
}

class BaseResponse<T> {
// می‌تونی ویژگی‌های مشترک پاسخ‌ها رو اینجا اضافه کنی
}
