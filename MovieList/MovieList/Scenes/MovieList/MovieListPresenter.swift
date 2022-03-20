import Foundation

protocol MovieListPresenting: AnyObject {
    
}

final class MovieListPresenter {
    private let coordinator: MovieListCoordinating
    weak var viewController: MovieListDisplay?
    
    init(coordinator: MovieListCoordinating) {
        self.coordinator = coordinator
    }
}

extension MovieListPresenter: MovieListPresenting {
    
}
