import UIKit

protocol MovieListCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class MovieListCoordinator {
    weak var viewController: UIViewController?
}

extension MovieListCoordinator: MovieListCoordinating {
}
