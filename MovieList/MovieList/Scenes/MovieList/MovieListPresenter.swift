import Foundation

protocol MovieListPresenting: AnyObject {
    func presentLoading()
    func stopPresentingLoading()
}

final class MovieListPresenter {
    private let coordinator: MovieListCoordinating
    weak var viewController: MovieListDisplay?
    
    init(coordinator: MovieListCoordinating) {
        self.coordinator = coordinator
    }
}

extension MovieListPresenter: MovieListPresenting {
    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func stopPresentingLoading() {
        viewController?.hideLoading()
    }
}
