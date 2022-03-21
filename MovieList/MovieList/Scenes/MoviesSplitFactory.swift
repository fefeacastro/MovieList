import UIKit

final class MoviesSplitFactory {
    func make() -> UIViewController {
        let splitViewController = UISplitViewController()
        let movieListController = MovieListFactory().make()
        let navigationController = UINavigationController(rootViewController: movieListController)
        navigationController.navigationBar.barTintColor = .systemIndigo
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemGray6]
        navigationController.navigationBar.tintColor = .systemGray6
        navigationController.navigationBar.isTranslucent = false

        splitViewController.viewControllers = [navigationController]
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self

        return splitViewController
    }
}

extension MoviesSplitFactory: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {

        return true
    }
}
