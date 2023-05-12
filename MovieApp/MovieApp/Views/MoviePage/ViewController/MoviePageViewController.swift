import UIKit

class MoviePageViewController: UIViewController, RefreshableViewController {

  // MARK: Properties
  
  private var viewModel: MoviePageViewModelProtocol?
  var spinner: SpinnerViewController = SpinnerViewController()
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
    viewModel?.detailsDelegate = self
    setupUI()
    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupUI()
  }
  
  // MARK: @IBAction
  
  @IBAction func saveMovie(_ sender: UIButton) {
    viewModel?.saveCurrentMovie()
  }

  @IBAction func deleteMovie(_ sender: UIButton) {
    viewModel?.deleteCurrentMovie()
  }

  // MARK: - Public
  
  func loadData() {
    showSpinner()
    viewModel?.fetchMovieDetails(by: self.movieID ?? "")
  }
  
  // MARK: - Private
  
  private func setupUI() {
    movieDescription?.sizeToFit()
    movieDescription?.baselineAdjustment = .alignCenters
    
    saveButton.tintColor = traitCollection.userInterfaceStyle == .light ? Constants.Colors.saveButtonLightThemeColor: Constants.Colors.saveButtonDarkThemeColor
    deleteButton.tintColor = .deleteButton
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
      self.hideSpinner()
    }
  }
}
