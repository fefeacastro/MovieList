import UIKit

final class MovieListFactory {
    func make() -> UIViewController {
        let coordinator = MovieListCoordinator()
        let presenter = MovieListPresenter(coordinator: coordinator)
        let service = MovieListService()
        let interactor = MovieListInteractor(presenter: presenter, service: service)
        let viewController = MovieListViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
