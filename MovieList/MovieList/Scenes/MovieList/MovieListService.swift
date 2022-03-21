import Foundation

protocol MovieListServicing {
    func requestTrendingDayMovies(completion: @escaping (Result<MoviesResponse, WebServiceError>) -> Void)
}

final class MovieListService: MovieListServicing {
    func requestTrendingDayMovies(completion: @escaping (Result<MoviesResponse, WebServiceError>) -> Void) {
        BaseWebService().request(path: .trending, mediaType: .movie, timeWindow: .day) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
