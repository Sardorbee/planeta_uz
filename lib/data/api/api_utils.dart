import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:planeta_uz/data/model/universal.dart';


UniversalData handleHttpErrors(http.Response response) {
  switch (response.statusCode) {
    case HttpStatus.badRequest:
      {
        return UniversalData(
          error: "Bad request exception",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.unauthorized:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.forbidden:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notFound:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.methodNotAllowed:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notAcceptable:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.proxyAuthenticationRequired:
      {
        return UniversalData(
          error: "Proxy authentication required",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.requestTimeout:
      {
        return UniversalData(
          error: "Request timeout",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.conflict:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.gone:
      {
        return UniversalData(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.lengthRequired:
      {
        return UniversalData(
          error: "Length required",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.preconditionFailed:
      {
        return UniversalData(
          error: "Precondition failed",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.requestEntityTooLarge:
      {
        return UniversalData(
          error: "Request entity too large",
          statusCode: response.statusCode,
        );
      }

    case HttpStatus.unsupportedMediaType:
      {
        return UniversalData(
          error: "Unsupported media type",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.requestedRangeNotSatisfiable:
      {
        return UniversalData(
          error: "Requested range not satisfiable",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.expectationFailed:
      {
        return UniversalData(
          error: "Expectation failed",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.internalServerError:
      {
        return UniversalData(
          error:
              "Error occurred while Communication with Server with StatusCode : ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notImplemented:
      {
        return UniversalData(
          error: "Server Error : ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.badGateway:
      {
        return UniversalData(
          error: "Bad gateway",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.serviceUnavailable:
      {
        return UniversalData(
          error: "Service unavailable",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.gatewayTimeout:
      {
        return UniversalData(
          error: "Gateway timeout",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.httpVersionNotSupported:
      {
        return UniversalData(
          error: "HTTP version not supported",
          statusCode: response.statusCode,
        );
      }
    default:
      return UniversalData(
        error: "Unknown Error occurred!",
        statusCode: response.statusCode,
      );
  }
}