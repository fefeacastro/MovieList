@testable import MovieList
import XCTest

private final class MovieListSpyViewController: MovieListDisplay {
    private(set) var displayLoadingCallsCount = 0
    private(set) var hideLoadingCallsCount = 0
    private(set) var displayMoviesCallsCount = 0
    private(set) var movies: [Movie]?
    
    func displayLoading() {
        displayLoadingCallsCount += 1
    }
    
    func hideLoading() {
        hideLoadingCallsCount += 1
    }
    
    func displayMovies(movies: [Movie]) {
        displayMoviesCallsCount += 1
        self.movies = movies
    }
}

private final class MovieListCoordinatorSpy: MovieListCoordinating {
    var viewController: UIViewController?
}

class MovieListPresenterTests: XCTestCase {
    // MARK: - Variables
    private let coordinator = MovieListCoordinatorSpy()
    private let viewController = MovieListSpyViewController()

    private lazy var presenter: MovieListPresenter  = {
        let presenter = MovieListPresenter(coordinator: coordinator)
        presenter.viewController = viewController
        return presenter
    }()
    
    private let movies: [Movie] = [Movie(title: "filme 1", overview: "teste", adult: true, posterPath: ""), Movie(title: "filme 2", overview: "teste", adult: true, posterPath: "")]

    // MARK: - test presentMovies
    func testPresentMovies_ShouldCallDisplayMovies() throws {
        presenter.presentMovies(movies: movies)

        let fakeMovies = try XCTUnwrap(viewController.movies)

        XCTAssertEqual(viewController.displayMoviesCallsCount, 1)
        XCTAssertEqual(fakeMovies, movies)
    }
    
    // MARK: - test presentLoading
    func testPresentLoading_ShouldCallDisplayLoading() {
        presenter.presentLoading()

        XCTAssertEqual(viewController.displayLoadingCallsCount, 1)
    }

    // MARK: - test stopPresentingLoading
    func testStopPresentingLoading_ShouldCallHideLoading() {
        presenter.stopPresentingLoading()

        XCTAssertEqual(viewController.hideLoadingCallsCount, 1)
    }
}
