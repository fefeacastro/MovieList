import UIKit

class MovieCell: UITableViewCell {
    lazy var movieImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(_ movie: Movie) {
        titleLabel.text = movie.title
        //movieImage.image =
    }
}

extension MovieCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
