import Foundation

enum WebServiceError: Error {
    case noInternet
    case timedOut
    case unexpected
    case URLFormat
    case unparseable
    case empty
}
