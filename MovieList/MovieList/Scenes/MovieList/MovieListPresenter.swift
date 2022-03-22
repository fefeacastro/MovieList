import Foundation

protocol MovieListPresenting: AnyObject {
    func presentLoading()
    func stopPresentingLoading()
    func presentMovies(movies: [Movie])
    func presentErrorMessage(message: String)
    func presentTryAgainButton()
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
    
    func presentErrorMessage(message: String) {
        viewController?.displayMessage(message: message)
    }
    
    func presentTryAgainButton() {
        viewController?.displayTryAgainButton()
    }
}
