import UIKit

class MoviePageViewController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel: MoviePageViewModelProtocol?
    
    var coordinator: MoviePageFlow?
    
    var movieID: String?
    
    @IBOutlet private weak var moviePoster: UIImageView?
    @IBOutlet private weak var movieTitle: UILabel?
    @IBOutlet private weak var movieDescription: UILabel?
    
    
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
    
    // MARK: Public
    
    func loadData() {
        self.viewModel?.fetchMovieDetails(by: self.movieID ?? "")
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
