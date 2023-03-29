import UIKit

class MoviePageViewController: UIViewController {
  
  // MARK: Properties
  
  private var viewModel: MoviePageViewModelProtocol?
  
  var movieID: String?
  
  @IBOutlet private weak var moviePoster: UIImageView?
  @IBOutlet private weak var movieTitle: UILabel?
  @IBOutlet private weak var movieDescription: UILabel?
  @IBOutlet private weak var saveButton: UIButton!
  @IBOutlet private weak var deleteButton: UIButton!

  convenience init(viewModel: MoviePageViewModelProtocol) {
    self.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewModel?.detailsDelegate = self
    movieDescription?.sizeToFit()
    movieDescription?.baselineAdjustment = .alignCenters
    loadData()
  }
  
  // MARK: @IBAction
  
  @IBAction func saveMovie(_ sender: UIButton) {
    viewModel?.saveCurrentMovie()
  }

  @IBAction func deleteMovie(_ sender: UIButton) {
    viewModel?.deleteCurrentMovie()
  }

  // MARK: Public
  
  func loadData() {
    viewModel?.fetchMovieDetails(by: self.movieID ?? "")
  }
}

extension MoviePageViewController: DetailsDelegate {
  func updateView() {
    DispatchQueue.main.async {
      guard let data = self.viewModel?.getMovieDetails() else {
        return
      }
      
      self.moviePoster?.load(from: data.poster)
      self.movieTitle?.text = data.title
      self.movieDescription?.text = data.plot
      
      self.view.layoutIfNeeded()
    }
  }
}
