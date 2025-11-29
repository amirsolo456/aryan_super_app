import '../Data/Auth/Toolbar/dto.dart';
import 'enums.dart';

class Opened {
  String? formId;
  String? caption;
  String? uRL;
  int? index;
  bool? isSelected;
  String? icon;
  int? repoViewID;
  int? refID;
  int? systemId;
  bool? hasBtnNavigation;
  bool? isHistory;
  bool? isCopy;
  int? headerType;
  OpenedType openedType = OpenedType.open;
  FormType? formType;
  Response? toolbarData;
  List<OpenedData?>? openedData;
}

class OpenedData {
  int? openedId;
  String? name;
  Object? value;
  OpenedDataType? type;
}
