import Foundation

protocol MovieListPresenting: AnyObject {
    func presentLoading()
    func stopPresentingLoading()
    func presentMovies(movies: [Movie])
}

final class MovieListPresenter {
    private let coordinator: MovieListCoordinating
    weak var viewController: MovieListDisplay?
    
    init(coordinator: MovieListCoordinating) {
        self.coordinator = coordinator
    }
}

extension MovieListPresenter: MovieListPresenting {
    func presentMovies(movies: [Movie]) {
        viewController?.displayMovies(movies: movies)
    }

    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func stopPresentingLoading() {
        viewController?.hideLoading()
    }
}
