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
                self.handleSuccess(moviesResponse)
            case let .failure(error):
                self.handleRequestFailure(error)
            }
        }
    }
}

private extension MovieListInteractor {
    func handleRequestFailure(_ error: WebServiceError) {
        switch error {
        case .noInternet:
            self.showError(message: Strings.Errors.noInternet)
        case .timedOut:
            self.showError(message: Strings.Errors.timeOut)
        default:
            self.showError(message: Strings.Errors.unexpected)
        }
    }
    
    func handleSuccess(_ response: MoviesResponse) {
        guard response.results.isEmpty else {
            self.presenter.presentMovies(movies: response.results)
            return
        }
        self.showError(message: Strings.Errors.noMovies)
    }
    
    func showError(message: String){
        self.presenter.presentErrorMessage(message: message)
        self.presenter.presentTryAgainButton()
    }
}
