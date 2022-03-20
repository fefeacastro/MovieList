import Foundation

protocol WebService {
    func request<T: Decodable>(
        path: Path,
        mediaType: MediaType,
        timeWindow: TimeWindow,
        method: HTTPMethod,
        parameters: [String: Any],
        completion: @escaping (Result<T, WebServiceError>) -> Void
    )
}

extension WebService {
    func request<T: Decodable>(
        path: Path,
        mediaType: MediaType,
        timeWindow: TimeWindow,
        method: HTTPMethod = .get,
        completion: @escaping (Result<T, WebServiceError>) -> Void
    ) {
        request(path: path, mediaType: mediaType, timeWindow: timeWindow, method: method, completion: completion)
    }
}
