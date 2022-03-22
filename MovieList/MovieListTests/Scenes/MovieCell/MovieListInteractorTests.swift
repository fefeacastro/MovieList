@testable import MovieList
import XCTest

private final class MovieListPresenterSpy: MovieListPresenting {
    private(set) var presentLoadingCallsCount = 0
    private(set) var stopPresentingLoadingCallsCount = 0
    private(set) var presentMoviesCallsCount = 0
    private(set) var presentErrorMessageCallsCount = 0
    private(set) var presentTryAgainButtonCallsCount = 0
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
    
    func presentTryAgainButton() {
        presentTryAgainButtonCallsCount += 1
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
    
    func testRequestMovies_ShouldCallPresentErrorWithNoMovieMessage_WhenServiceReturnsSuccessWithNoMovie() throws {
        service.result = .success(MoviesResponse(results: []))
        interactor.requestMovies()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.presentErrorMessageCallsCount, 1)
        XCTAssertEqual(presenter.presentTryAgainButtonCallsCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Errors.noMovies)
    }
    
    func testRequestMovies_ShouldCallPresentErrorWithUnexpectedMessage_WhenServiceReturnsUnexpected() throws {
        service.result = .failure(.unexpected)
        interactor.requestMovies()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.presentErrorMessageCallsCount, 1)
        XCTAssertEqual(presenter.presentTryAgainButtonCallsCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Errors.unexpected)
    }
    
    func testRequestMovies_ShouldCallPresentErrorWithUnexpectedMessage_WhenServiceReturnsURLFormat() throws {
        service.result = .failure(.URLFormat)
        interactor.requestMovies()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.presentErrorMessageCallsCount, 1)
        XCTAssertEqual(presenter.presentTryAgainButtonCallsCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Errors.unexpected)
    }
    
    func testRequestMovies_ShouldCallPresentErrorWithUnexpectedMessage_WhenServiceReturnsUnparseable() throws {
        service.result = .failure(.unparseable)
        interactor.requestMovies()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.presentErrorMessageCallsCount, 1)
        XCTAssertEqual(presenter.presentTryAgainButtonCallsCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Errors.unexpected)
    }
    
    func testRequestMovies_ShouldCallPresentErrorWithTimeOutMessage_WhenServiceReturnsTimedOutError() throws {
        service.result = .failure(.timedOut)
        interactor.requestMovies()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.presentErrorMessageCallsCount, 1)
        XCTAssertEqual(presenter.presentTryAgainButtonCallsCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Errors.timeOut)
    }
    
    func testRequestMovies_ShouldCallPresentErrorWithNoInternetMessage_WhenServiceReturnsNotConnectedToInternetError() throws {
        service.result = .failure(.noInternet)
        interactor.requestMovies()

        let fakeMessage = try XCTUnwrap(presenter.message)

        XCTAssertEqual(presenter.presentErrorMessageCallsCount, 1)
        XCTAssertEqual(presenter.presentTryAgainButtonCallsCount, 1)
        XCTAssertEqual(fakeMessage, Strings.Errors.noInternet)
    }
}
