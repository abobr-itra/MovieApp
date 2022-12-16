import UIKit

class MoviePageViewController: UIViewController {
  
  // MARK: Properties
  
  // TODO: Create fabric for VM
  private var viewModel: MovieViewModelProtocol = MovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
  
  var movieDetails: MovieDetails?
  var movieID: String?
  
  @IBOutlet private weak var moviePoster: UIImageView!
  @IBOutlet private weak var movieTitle: UILabel!
  @IBOutlet private weak var movieDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  // MARK: Public
  
  // MARK: Private
  
}

extension MoviePageViewController: DetailsDelegate {
  func updateView(with data: MovieDetails) {
    DispatchQueue.main.async {
      self.moviePoster.load(from: data.poster)
      self.movieTitle.text = data.title
      self.movieDescription.text = data.plot
    }
  }
}
