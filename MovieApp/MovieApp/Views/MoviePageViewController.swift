import UIKit

class MoviePageViewController: UIViewController {
  
  // MARK: Properties
  
  var movie: Movie?
  
  @IBOutlet weak var moviePoster: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    print(movie)
    setUpMoviePage()
  }
  
  // MARK: Public
  
  // MARK: Private
  private func setUpMoviePage() {
    DispatchQueue.main.async { [weak self] in
      self?.moviePoster.load(from: self?.movie?.poster)
      self?.movieTitle.text = self?.movie?.title ?? ""
      self?.movieDescription.text = self?.movie?.year ?? ""
    }
  }
  
}
