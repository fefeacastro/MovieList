import Foundation

enum Path: String {
    case movie
}

struct API {
    private let host = "https://api.themoviedb.org"
    private let version = "3"

    static let headerKey = "550?api_key="
    static let key = "4f79fe4b08c2abe4e6c06d1951c90731"

    private let path: Path

    init(path: Path) {
        self.path = path
    }

    var value: String {
        "\(host)/\(version)/\(path.rawValue)"
    }
}
