import UIKit
import Combine

class MoviePageViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    private var viewModel: MoviePageViewModelProtocol?
    var spinner: SpinnerViewController = SpinnerViewController()
    private var subscriptions = Set<AnyCancellable>()
    
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
        
        setupUI()
        setupViewModel()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - @IBAction
    
    @IBAction func saveMovie(_ sender: UIButton) {
        viewModel?.saveCurrentMovie()
    }
    
    @IBAction func deleteMovie(_ sender: UIButton) {
        viewModel?.deleteCurrentMovie()
    }
    
    // MARK: - Public
    
    func setupViewModel() {
        guard let viewModel = viewModel as? MoviePageViewModel else { // FIXME: Solution to use @Publised properties
            return
        }
        viewModel.$isLoading
            .sink { isLoading in
                DispatchQueue.main.async { [weak self] in
                    if isLoading {
                        self?.showSpinner()
                    } else {
                        self?.hideSpinner()
                    }
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$isDataLoaded
            .sink { isLoaded in
                if isLoaded {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupView()
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .tabBarTintColor
        navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        movieDescription?.sizeToFit()
        movieDescription?.baselineAdjustment = .alignCenters
        
        saveButton.tintColor = traitCollection.userInterfaceStyle == .light ? Constants.SaveButton.lightThemeColor: Constants.SaveButton.darkThemeColor
        deleteButton.tintColor = .deleteButtonColor
    }
    
    private func setupView() {
        guard let data = viewModel?.movieDetails else {
            return
        }
        
        moviePoster?.load(from: data.poster)
        movieTitle?.text = data.title
        movieDescription?.text = data.plot
        
        view.layoutIfNeeded()
    }
}
