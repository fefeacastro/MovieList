import UIKit

protocol MovieListDisplay: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayMovies(movies: [Movie])
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
        tableView.rowHeight = 140
        tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var model = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filmes"
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
