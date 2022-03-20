protocol MovieListInteracting: AnyObject {
    
}

final class MovieListInteractor {
    private let presenter: MovieListPresenting
    private let service: MovieListServicing
    
    init(presenter: MovieListPresenting, service: MovieListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension MovieListInteractor: MovieListInteracting {
    
}
