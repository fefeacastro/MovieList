@testable import MovieList
import XCTest

struct TestModel: Codable {
    let test: String
}

extension BaseWebService {
    static func jsonDataSuccess() -> Data? {
        let jsonSuccess: [String: String] = ["test": "completed"]
        return try? JSONSerialization.data(withJSONObject: jsonSuccess)
    }

    static func notJSONDataSuccess() -> Data {
        let string = "test"
        return Data(base64Encoded: string)!
    }
}

class BaseWebServiceTests: XCTestCase {
    private let service = BaseWebService()
    
}
