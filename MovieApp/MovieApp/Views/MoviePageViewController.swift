import UIKit

class MoviePageViewController: UIViewController {
  
  // MARK: Properties

  private var viewModel: SearchMovieViewModelProtocol = SearchMovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
  
  var coordinator: MoviePageFlow?
  var movieDetails: MovieDetails?
  var movieID: String?
  
  @IBOutlet private var moviePoster: UIImageView?
  @IBOutlet private var movieTitle: UILabel?
  @IBOutlet private var movieDescription: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewModel.detailsDelegate = self
    updateView()
  }

  // MARK: Public
  
  func updateView() {
    self.viewModel.fetchMovieDetails(by: self.movieID ?? "")
  }
  
  // MARK: Private
}

extension MoviePageViewController: DetailsDelegate {
  func updateView(with data: MovieDetails) {
    DispatchQueue.main.async {
      self.moviePoster?.load(from: data.poster)
      self.movieTitle?.text = data.title
      self.movieDescription?.text = data.plot
    }
  }
}
