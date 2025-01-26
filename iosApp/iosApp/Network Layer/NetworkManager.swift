//
//  NetworkManager.swift
//  iosApp
//
//  Created by Kuriakose K Biju on 25/01/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: LocalizedError, Equatable {
    case badRequest
    case unauthorised
    case forbidden
    case notFound
    case serverError
    case decodingError( _ description: String)
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

extension NetworkError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Oops, something seems wrong with your request. Please double-check the information you entered and try again.", comment: "Bad Request")
        case .unauthorised:
            return NSLocalizedString("You need to log in to access the content. Please check your username and password and try again.", comment: "Unauthorised Request")
        case .forbidden:
            return NSLocalizedString("You don't have permission to access this. Please check if you are logged in correctly or contact the support for assistance.", comment: "Forbidden Request")
        case .notFound:
            return NSLocalizedString("Oops! It looks like the service you're looking for is not found.", comment: "Not found Request")
        case .serverError:
            return NSLocalizedString("Oops, looks like currently we are unable to process your request. Please retry or coming back later.", comment: "Server Error Request")
        case .decodingError(_):
            return NSLocalizedString("Oops, looks like currently we are unable to process your request. Please retry or coming back later.", comment: "Decoding Response Error")
        case .urlSessionFailed(let error):
            return NSLocalizedString(error.localizedDescription, comment: "URL Session Error")
        case .unknownError:
            return NSLocalizedString("Oops, something unexpected happened! We're looking into it, please try again later.", comment: "Unknown Error")
        }
    }
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: Any]? { get }
    var jsonDecoder: JSONDecoder? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    
    var queryParams: [String: Any]? { return nil }
    var jsonDecoder: JSONDecoder?  { return JSONDecoder() }
    
    func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else {
            return nil
        }
        return queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
    }
    
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = addQueryItems(queryParams: queryParams)
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue(APIConstants.apiToken, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        return request
    }
}

struct NetworkManager {
    
    let urlSession: URLSession!
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func networkRequest<ReturnType: Codable>(request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<ReturnType, NetworkError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw httpError(0)
                }
                if !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                return data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: ReturnType.self, decoder: decoder)
            .mapError { error in
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func httpError(_ statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorised
        case 403: return .forbidden
        case 404: return .notFound
        case 500...599: return .serverError
        default: return .unknownError
        }
    }
    
    private func handleError(_ error: Error) -> NetworkError {
        switch error {
        case is DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkError:
            return error
        default:
            return .unknownError
        }
    }
}

struct ApiHandler {
    
    static var sessionManager: NetworkManager = NetworkManager()
    static func callApi<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkError> {
        guard let urlRequest = request.asURLRequest(baseURL: APIConstants.basedURL) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkError>
        let requestPublisher: RequestPublisher = sessionManager.networkRequest(request: urlRequest, decoder: request.jsonDecoder ?? JSONDecoder())
        return requestPublisher.eraseToAnyPublisher()
    }
}
