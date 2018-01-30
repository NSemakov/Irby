// ----------------------------------------------------------------------------
//
//  AlertViewManager+RestApiError.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiRest

// ----------------------------------------------------------------------------

extension AlertViewManager
{
// MARK: - Methods

    class func showErrorAlertView(_ error: RestApiError)
    {
        let params = alertViewParamsForError(error)
        showAlertView(params.title, message: params.message)
    }

    class func alertViewParamsForError(_ error: RestApiError) -> AlertViewParams
    {
        let result: AlertViewParams

        switch error
        {
            case let error as TransportLayerError:
                result = paramsForTransportLayerError(error)

            case let error as ApplicationLayerError:
                result = paramsForApplicationLayerError(error)

// FIXME: Uncomment!
//            case let error as TopLevelProtocolError:
//                result = paramsForTopLevelProtocolError(error)

            default:
                result = paramsForUnexpectedError(error)
        }

        return result
    }

// MARK: - Private Methods

    fileprivate class func paramsForTransportLayerError(_ error: TransportLayerError) -> AlertViewParams
    {
        let result: AlertViewParams

        if (error.cause is ConnectionError)
        {
            result = AlertViewParams(title: nil, message: R.string.localizationAlert.cannotAccessServer())
        }
        else {
            result = paramsForUnexpectedError(error)
        }

        return result
    }

    fileprivate class func paramsForApplicationLayerError(_ error: ApplicationLayerError) -> AlertViewParams
    {
        let result: AlertViewParams

        if let cause = (error.cause as? ResponseError),
           let statusCode = cause.entity.status?.code
        {
            switch statusCode
            {
                // 401 Unauthorized
                case .unauthorized:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp401_Unauthorized(), message: R.string.localizationAlert.http401_Unauthorized())

                // 403 Forbidden
                case .forbidden:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp403_Forbidden(), message: R.string.localizationAlert.http403_Forbidden())

                // 404 Not Found
                case .notFound:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp404_NotFound(), message: R.string.localizationAlert.http404_NotFound())

                // 406 Not Acceptable
                case .notAcceptable:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp406_NotAcceptable(), message: R.string.localizationAlert.http406_NotAcceptable())

                // 422 Unprocessable Entity
                case .unprocessableEntity:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp422_UnprocessableEntity(), message: R.string.localizationAlert.http422_UnprocessableEntity())

                // 500 Internal Server Error
                case .internalServerError:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp500_InternalServerError(), message: R.string.localizationAlert.http500_InternalServerError())

                // 502 Bad Gateway
                case .badGateway:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp502_BadGateway(), message: R.string.localizationAlert.http502_BadGateway())

                // 503 Service Unavailable
                case .serviceUnavailable:
                    result = AlertViewParams(title: R.string.localizationAlert.titleHttp503_ServiceUnavailable(), message: R.string.localizationAlert.http503_ServiceUnavailable())

                default:
                    result = paramsForUnexpectedError(error)
            }
        }
        else
        if (error.cause is ConversionError) || (error.cause is UnexpectedMediaTypeError)
        {
            result = AlertViewParams(title: nil, message: R.string.localizationAlert.invalidResponse())
        }
        else {
            result = paramsForUnexpectedError(error)
        }

        return result
    }

    // FIXME: Uncomment!
//    private class func paramsForTopLevelProtocolError(error: TopLevelProtocolError)
//    {
//        guard let error = error.entity.body?.errors?.first else {
//            mdc_fatalError("Errors is empty")
//        }
//
//        showErrorAlertView(message: error.value)
//    }

    fileprivate class func paramsForUnexpectedError(_ error: RestApiError) -> AlertViewParams {
        return AlertViewParams(title: nil, message: R.string.localizationAlert.unexpectedHttpError())
    }

}

// ----------------------------------------------------------------------------
