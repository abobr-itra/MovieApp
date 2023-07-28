import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieCell"
    
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellUI()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        contentView.backgroundColor = highlighted ? Constants.Cell.highlightColor: Constants.Colors.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: Constants.Cell.inset)
    }
    
    // MARK: - Public
    
    func setUp(with movie: MovieModelProtocol?) {
        guard let movie = movie,
              let poster = URL(string: movie.posterUrl) else { return }
        
        accessibilityIdentifier = "MovieCell.\(movie.title)"
        movieTitle.text = "\(movie.title) (\(movie.year))"
        moviePoster.load(from: poster)
        movieYear.text = movie.type
    }
    
    // MARK: - Private
    
    private func setupCellUI() {
        selectionStyle = .none
        contentView.layer.borderWidth = Constants.Cell.borderWidth
        contentView.layer.cornerRadius = Constants.Cell.cornerRadius
        contentView.layer.shadowOffset = Constants.Cell.shadowOffset
        let borderColor = Constants.Cell.borderColor
        contentView.layer.borderColor = borderColor.cgColor
    }
}
