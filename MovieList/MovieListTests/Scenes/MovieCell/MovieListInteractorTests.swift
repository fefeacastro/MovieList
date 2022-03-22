@testable import MovieList
import XCTest

private final class MovieListPresenterSpy: MovieListPresenting {
    private(set) var presentLoadingCallsCount = 0
    private(set) var stopPresentingLoadingCallsCount = 0
    private(set) var presentMoviesCallsCount = 0
    private(set) var presentErrorMessageCallsCount = 0
    private(set) var movies: [Movie]?
    private(set) var message: String?
    
    func presentLoading() {
        presentLoadingCallsCount += 1
    }
    
    func stopPresentingLoading() {
        stopPresentingLoadingCallsCount += 1
    }
    
    func presentMovies(movies: [Movie]) {
        presentMoviesCallsCount += 1
        self.movies = movies
    }
    
    func presentErrorMessage(message: String) {
        presentErrorMessageCallsCount += 1
        self.message = message
    }
}

private final class MovieListServiceMock: MovieListServicing {
    var result: Result<MoviesResponse, WebServiceError>?

    func requestTrendingDayMovies(completion: @escaping (Result<MoviesResponse, WebServiceError>) -> Void) {
        guard let result = result else { return }
        completion(result)
    }
}

class MovieListInteractorTests: XCTestCase {
    //MARK: - Variables
    private let presenter = MovieListPresenterSpy()
    private let service = MovieListServiceMock()
    private let movies: [Movie] = [Movie(title: "filme 1", overview: "teste", adult: true, posterPath: ""), Movie(title: "filme 2", overview: "teste", adult: true, posterPath: "")]
    private lazy var moviesResponse: MoviesResponse = MoviesResponse(results: movies)
    
    private lazy var interactor = MovieListInteractor(presenter: presenter, service: service)
    
    // MARK: - test requestMovies
    func testRequestMovies_ShouldCallPresentLoading() {
        interactor.requestMovies()
        XCTAssertEqual(presenter.presentLoadingCallsCount, 1)
    }

    func testRequestMovies_ShouldCallHideLoading_WhenServiceReturns() {
        service.result = .failure(.unexpected)
        interactor.requestMovies()
        XCTAssertEqual(presenter.presentLoadingCallsCount, 1)
    }

    func testRequestMovies_ShouldCallPresentMovies_WhenServiceReturnsSuccess() throws {
        service.result = .success(moviesResponse)
        interactor.requestMovies()

        let fakeMovies = try XCTUnwrap(presenter.movies)

        XCTAssertEqual(presenter.presentLoadingCallsCount, 1)
        XCTAssertEqual(movies, fakeMovies)
    }
}
