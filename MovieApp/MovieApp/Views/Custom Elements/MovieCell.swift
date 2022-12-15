import UIKit

class MovieCell: UITableViewCell {
  
  // MARK: Properties
  
  static let identifier = "MovieCell"
  
  @IBOutlet weak var moviePoster: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieYear: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: Public
  
  func setUp(from movie: Movie) {
    movieTitle.text = movie.title
    moviePoster.load(from: movie.poster)
    movieYear.text = movie.year
  }
  
  // MARK: Private
  
}
