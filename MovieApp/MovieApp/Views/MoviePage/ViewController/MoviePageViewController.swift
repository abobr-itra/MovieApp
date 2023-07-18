import UIKit
import Combine

class MoviePageViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    private var viewModel: MoviePageViewModelProtocol?
    var spinner: SpinnerViewController = SpinnerViewController()
    private var subscriptions: Set<AnyCancellable> = []
    
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
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Public
    
    func setupViewModel() {
        viewModel?.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.showSpinner(isLoading)
            }
            .store(in: &subscriptions)
        
        viewModel?.isDataLoadedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoaded in
                if isLoaded {
                    self?.setupView()
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
