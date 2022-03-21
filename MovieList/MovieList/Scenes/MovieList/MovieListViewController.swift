import UIKit

protocol MovieListDisplay: AnyObject {
    func displayLoading()
    func hideLoading()
    func displayMovies(movies: [Movie])
}

final class MovieListViewController: ViewController<MovieListInteracting>, UITableViewDataSource, UITableViewDelegate {
    
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
        tableView.rowHeight = 120
        tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filmes"
        interactor.requestMovies()
    }
    
    // MARK: - View Configuration
    override func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        return cell
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
        
    }
}
