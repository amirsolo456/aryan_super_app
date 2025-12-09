import 'package:models_package/Base/question_button.dart';

abstract class ISnackbarService {
  void showSuccess(
    String msg, {
    Duration? duration,
    List<QuestionButton>? buttons,
  });
  void showError(
    String msg, {
    Duration? duration,
    List<QuestionButton>? buttons,
  });
  void showInfo(
    String msg, {
    Duration? duration,
    List<QuestionButton>? buttons,
  });
  void showQuestionBox(
    String msg, {
    Duration? duration,
    required List<QuestionButton> buttons,
  });
}
