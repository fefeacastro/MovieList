import UIKit

protocol MovieListDisplay: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayMovies(movies: [Movie])
    func displayMessage(message: String)
    func displayTryAgainButton()
}

final class MovieListViewController: ViewController<MovieListInteracting> {
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.setTitle(Strings.Errors.tryAgain, for: .normal)
        button.titleLabel?.font = UIFont.medium(weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()
    
    private var model = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.NavigationBar.movieList
        interactor.requestMovies()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
    
        self.view = view
    }
    
    // MARK: - View Configuration
    override func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MovieListViewController: MovieListDisplay {
    func displayLoading() {
        tableView.backgroundView = activity
    }
    
    func hideLoading() {
        activity.stopAnimating()
        tableView.backgroundView = nil
    }
    
    func displayMovies(movies: [Movie]) {
        self.model = movies
        self.tableView.reloadData()
    }
    
    func displayMessage(message: String) {
        let errorView = ErrorView(errorMessage: message)
        tableView.addSubview(errorView)
        tableView.backgroundView = errorView
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func displayTryAgainButton() {
        view.addSubview(tryAgainButton)
        tryAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        tryAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tryAgainButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15).isActive = true
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = model[indexPath.row]
        cell.setup(movie)
        return cell
    }
}

private extension MovieListViewController {
    @objc func tryAgain() {
        tryAgainButton.removeFromSuperview()
        interactor.requestMovies()
    }
}
