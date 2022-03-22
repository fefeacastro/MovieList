import Foundation

enum Path: String {
    case trending
}

enum MediaType: String {
    case all
    case movie
    case tv
    case person
}

enum TimeWindow: String {
    case day
    case week
}

struct API {
    private let host = "https://api.themoviedb.org"
    private let version = "3"

    private let headerKey = "?api_key="
    private let key = "4f79fe4b08c2abe4e6c06d1951c90731"

    private let path: Path
    private let mediaType: MediaType
    private let timeWindow: TimeWindow

    init(path: Path, mediaType: MediaType, timeWindow: TimeWindow) {
        self.path = path
        self.mediaType = mediaType
        self.timeWindow = timeWindow
    }

    var value: String {
        "\(host)/\(version)/\(path.rawValue)/\(mediaType.rawValue)/\(timeWindow.rawValue)\(headerKey)\(key)"
    }
    
    static func moviePoster(path: String) -> URL? {
        let posterHost = "https://image.tmdb.org/t/p/w500"
        return URL(string: "\(posterHost)\(path)")
    }
}
