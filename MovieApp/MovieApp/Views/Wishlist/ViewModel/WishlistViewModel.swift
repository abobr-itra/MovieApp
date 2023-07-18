import Foundation
import Combine

class WishlistViewModel: MovieViewModelProtocol, WishlistViewModelProtocol {
    
    // MARK: - Properties

    @Published private var isDataLoaded = false
    @Published private var isLoading = false
    
    var isDataLoadedPublisher: Published<Bool>.Publisher { $isDataLoaded }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    private var dataService: RealmServiceProtocol
    private(set) var moviesDB: [RealmMovie] = []
    var moviesCount: Int {
        moviesDB.count
    }
    
    init(dataService: RealmServiceProtocol) {
        self.dataService = dataService
    }
    
    // MARK: - Public
    
    func loadWishlist() {
        isLoading = true
        isDataLoaded = false
        DispatchQueue.global().async { [weak self] in
            self?.dataService.getAllMovies { result in
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.moviesDB = data
                    self?.isDataLoaded = true
                case .failure(let error):
                    print("Something went wrong: \(error)")
                }
            }
        }
    }
    
    func deleteMovie(by id: String) {
        dataService.deleteMovie(by: id)
    }
    
    func movie(at index: Int) -> MovieModelProtocol {
        moviesDB[index]
    }
}
