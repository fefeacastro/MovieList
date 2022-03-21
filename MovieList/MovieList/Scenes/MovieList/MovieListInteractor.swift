protocol MovieListInteracting: AnyObject {
    func requestMovies()
}

final class MovieListInteractor {
    private let presenter: MovieListPresenting
    private let service: MovieListServicing
    private var moviesResponse = MoviesResponse(results: [Movie]())
    
    init(presenter: MovieListPresenting, service: MovieListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension MovieListInteractor: MovieListInteracting {
    func requestMovies() {
        presenter.presentLoading()
        service.requestTrendingDayMovies { [weak self] result in
            guard let self = self else { return }
            self.presenter.stopPresentingLoading()
            switch result {
            case let .success(moviesResponse):
                self.moviesResponse = moviesResponse
            case let .failure(error):
                self.handleRequestFailure(error)
            }
        }
    }
}

private extension MovieListInteractor {
    func handleRequestFailure(_ error: WebServiceError) {
        
    }
}
