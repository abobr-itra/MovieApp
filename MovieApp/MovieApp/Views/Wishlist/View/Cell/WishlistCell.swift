import UIKit

class WishlistCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "WishlistCell"
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    
    override func awakeFromNib() {
      super.awakeFromNib()
    }

    // MARK: Public
    
    func setUp(from movie: RealmMovie?) {
      guard let movie = movie else { return }
      
      movieTitle.text = "\(movie.title) (\(movie.year))"
      
    moviePoster.load(from: movie.posterUrl)
      movieYear.text = movie.type
    }
    
    // MARK: Private
    
    
}
