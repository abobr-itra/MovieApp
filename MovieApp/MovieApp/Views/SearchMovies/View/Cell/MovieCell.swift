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
  
  func setUp(from movie: Movie?) {
    guard let movie = movie else { return }
    
    movieTitle.text = "\(movie.title) (\(movie.year))"
    moviePoster.load(from: movie.poster)
    movieYear.text = movie.type
  }
  
  func setUp(from movie: RealmMovie?) {
    guard let movie = movie,
          let poster = URL(string: movie.posterUrl) else { return }
    
    movieTitle.text = "\(movie.title) (\(movie.year))"
    moviePoster.load(from: poster)
    movieYear.text = movie.type
  }
  
  // MARK: Private
  
}
