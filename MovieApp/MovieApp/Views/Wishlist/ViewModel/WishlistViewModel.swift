import Foundation

class WishlistViewModel: MovieViewModelProtocol, WishlistViewModelProtocol {
    
    // MARK: - Properties
    
    var onDataLoaded: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    private var dataService: RealmServiceProtocol
    private(set) var moviesDB: [RealmMovie] = []
    var moviesCount: Int {
        return moviesDB.count
    }
    
    init(dataService: RealmServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Public
    
    func loadWishlist() {
        onLoading?(true)
        DispatchQueue.global().async { [weak self] in
            self?.dataService.getAllObjects(ofType: RealmMovie.self) { result in
                DispatchQueue.main.async {
                    self?.onLoading?(false)
                }
                switch result {
                case .success(let data):
                    self?.moviesDB = data
                    self?.onDataLoaded?()
                case .failure(let error):
                    print("Something went wrong: \(error)")
                }
            }
        }
    }
    
    func deleteMovie(by id: String) {
        dataService.deleteObject(ofType: RealmMovie.self) { $0.imdbID == id }
    }
    
    func movie(at index: Int) -> MovieModelProtocol {
        moviesDB[index]
    }
}
