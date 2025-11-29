import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_exception/http_exception.dart';

HttpException? apiExceptionValidator(http.Response response) {
  final int statusCode = response.statusCode;

  if (statusCode >= 200 && statusCode < 300) {
    return null;
  }

  final Uri? uri = response.request?.url;

  dynamic data;
  try {
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
    } else {
      data = response.headers;
    }
  } catch (_) {
    data = response.body.isNotEmpty ? response.body : response.headers;
  }

  switch (statusCode) {
    case 400:
      return BadRequestHttpException(
        detail: 'Bad Request',
        data: data,
        uri: uri,
      );
    case 401:
      return UnauthorizedHttpException(
        detail: 'Unauthorized',
        data: data,
        uri: uri,
      );
    case 402:
      return PaymentRequiredHttpException(
        detail: 'Payment Required',
        data: data,
        uri: uri,
      );
    case 403:
      return ForbiddenHttpException(detail: 'Forbidden', data: data, uri: uri);
    case 404:
      return NotFoundHttpException(detail: 'Not Found', data: data, uri: uri);
    case 405:
      return MethodNotAllowedHttpException(
        detail: 'Method Not Allowed',
        data: data,
        uri: uri,
      );
    case 406:
      return NotAcceptableHttpException(
        detail: 'Not Acceptable',
        data: data,
        uri: uri,
      );
    case 407:
      return ProxyAuthenticationRequiredHttpException(
        detail: 'Proxy Authentication Required',
        data: data,
        uri: uri,
      );
    case 408:
      return RequestTimeoutHttpException(
        detail: 'Request Timeout',
        data: data,
        uri: uri,
      );
    case 409:
      return ConflictHttpException(detail: 'Conflict', data: data, uri: uri);
    case 410:
      return GoneHttpException(detail: 'Gone', data: data, uri: uri);
    case 411:
      return LengthRequiredHttpException(
        detail: 'Length Required',
        data: data,
        uri: uri,
      );
    case 412:
      return PreconditionFailedHttpException(
        detail: 'Precondition Failed',
        data: data,
        uri: uri,
      );
    case 413:
    case 414:
      return RequestUriTooLongHttpException(
        detail: 'Request-URI Too Long',
        data: data,
        uri: uri,
      );
    case 415:
      return UnsupportedMediaTypeHttpException(
        detail: 'Unsupported Media Type',
        data: data,
        uri: uri,
      );
    case 416:
      return RequestedRangeNotSatisfiableHttpException(
        detail: 'Requested Range Not Satisfiable',
        data: data,
        uri: uri,
      );
    case 417:
      return ExpectationFailedHttpException(
        detail: 'Expectation Failed',
        data: data,
        uri: uri,
      );
    case 418:
      return ImATeapotHttpException(
        detail: 'Im a teapot',
        data: data,
        uri: uri,
      );
    case 419:
      return InsufficientSpaceOnResourceHttpException(
        detail: 'Insufficient Space On Resource',
        data: data,
        uri: uri,
      );
    case 420:
      return MethodFailureHttpException(
        detail: 'Method Failure',
        data: data,
        uri: uri,
      );
    case 421:
      return MisdirectedRequestHttpException(
        detail: 'Misdirected Request',
        data: data,
        uri: uri,
      );
    case 422:
      return UnprocessableEntityHttpException(
        detail: 'Unprocessable Entity',
        data: data,
        uri: uri,
      );
    case 423:
      return LockedHttpException(detail: 'Locked', data: data, uri: uri);
    case 424:
      return FailedDependencyHttpException(
        detail: 'Failed Dependency',
        data: data,
        uri: uri,
      );
    case 426:
      return UpgradeRequiredHttpException(
        detail: 'Upgrade Required',
        data: data,
        uri: uri,
      );
    case 428:
      return PreconditionRequiredHttpException(
        detail: 'Precondition Required',
        data: data,
        uri: uri,
      );
    case 429:
      return TooManyRequestsHttpException(
        detail: 'Too Many Requests',
        data: data,
        uri: uri,
      );
    case 431:
      return RequestHeaderFieldsTooLargeHttpException(
        detail: 'Request Header Fields Too Large',
        data: data,
        uri: uri,
      );
    case 444:
      return ConnectionClosedWithoutResponseHttpException(
        detail: 'Connection Closed Without Response',
        data: data,
        uri: uri,
      );
    case 451:
      return UnavailableForLegalReasonsHttpException(
        detail: 'Unavailable For Legal Reasons',
        data: data,
        uri: uri,
      );
    case 499:
      return ClientClosedRequestHttpException(
        detail: 'Client Closed Request',
        data: data,
        uri: uri,
      );
    case 500:
      return InternalServerErrorHttpException(
        detail: 'Internal Server Error',
        data: data,
        uri: uri,
      );
    case 501:
      return NotImplementedHttpException(
        detail: 'Not Implemented',
        data: data,
        uri: uri,
      );
    case 502:
      return BadGatewayHttpException(
        detail: 'Bad Gateway',
        data: data,
        uri: uri,
      );
    case 503:
      return ServiceUnavailableHttpException(
        detail: 'Service Unavailable',
        data: data,
        uri: uri,
      );
    case 504:
      return GatewayTimeoutHttpException(
        detail: 'Gateway Timeout',
        data: data,
        uri: uri,
      );
    case 505:
      return HttpVersionNotSupportedHttpException(
        detail: 'HTTP Version Not Supported',
        data: data,
        uri: uri,
      );
    case 506:
      return VariantAlsoNegotiatesHttpException(
        detail: 'Variant Also Negotiates',
        data: data,
        uri: uri,
      );
    case 507:
      return InsufficientStorageHttpException(
        detail: 'Insufficient Storage',
        data: data,
        uri: uri,
      );
    case 508:
      return LoopDetectedHttpException(
        detail: 'Loop Detected',
        data: data,
        uri: uri,
      );
    case 510:
      return NotExtendedHttpException(
        detail: 'Not Extended',
        data: data,
        uri: uri,
      );
    case 511:
      return NetworkAuthenticationRequiredHttpException(
        detail: 'Network Authentication Required',
        data: data,
        uri: uri,
      );
    case 599:
      return NetworkConnectTimeoutErrorHttpException(
        detail: 'Network Connect Timeout Error',
        data: data,
        uri: uri,
      );
    default:
      return null;
  }
}

void validateResponseStatus(http.Response response) {
  final HttpException? ex = apiExceptionValidator(response);
  if (ex != null) {
    throw ex;
  }
}
