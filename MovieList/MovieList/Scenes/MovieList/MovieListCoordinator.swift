import UIKit

protocol MovieListCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func showMovieDetails(_ movie: Movie)
}

final class MovieListCoordinator {
    weak var viewController: UIViewController?
}

extension MovieListCoordinator: MovieListCoordinating {
    func showMovieDetails(_ movie: Movie) {
        // TO DO: movie details page
    }
    
}
