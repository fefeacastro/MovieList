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
        label.font = UIFont.title()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var adultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title(weight: .semibold)
        label.text = Strings.Adult.isAdult
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title(weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
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
        
        guard let vote = movie.voteAverage else {
            return
        }
        
        voteLabel.text = vote.description + Strings.Votes.star
    }
}

extension MovieCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(adultLabel)
        contentView.addSubview(voteLabel)
//        contentView.addSubview(movieImage)
    }
    
    func setupConstraints() {
//        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
//        movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        movieImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
//        movieImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        
        overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -7).isActive = true
        
        adultLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
        adultLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        voteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        voteLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
    
}
