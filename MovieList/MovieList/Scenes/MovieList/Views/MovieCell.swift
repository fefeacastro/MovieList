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
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var adultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = Strings.Adult.isAdult
        label.isHidden = true
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
        overviewLabel.text = movie.overview
        if movie.adult ?? false {
            adultLabel.isHidden = false
        }
        buildLayout()
    }
}

extension MovieCell: ViewConfiguration {
    func buildViewHierarchy() {
//        contentView.addSubview(movieImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(adultLabel)
    }
    
    func setupConstraints() {
//        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
//        movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        movieImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        movieImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        
        adultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        adultLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
    }
    
}
