import UIKit

class MovieCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        contentView.backgroundColor = highlighted ? Constants.Cell.highlightColor: Constants.Colors.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: Constants.Cell.inset)
        contentView.layer.borderWidth = Constants.Cell.borderWidth
        contentView.layer.cornerRadius = Constants.Cell.cornerRadius
        contentView.layer.shadowOffset = Constants.Cell.shadowOffset
        let borderColor = traitCollection.userInterfaceStyle == .light ? Constants.Cell.lightBorderColor: Constants.Cell.darkBorderTheme
        contentView.layer.borderColor = borderColor.cgColor
    }
    
    // MARK: - Public
    
    func setUp(from movie: MovieModelProtocol?) {
        guard let movie = movie,
              let poster = URL(string: movie.posterUrl) else { return }
        
        movieTitle.text = "\(movie.title) (\(movie.year))"
        moviePoster.load(from: poster)
        movieYear.text = movie.type
    }
}
