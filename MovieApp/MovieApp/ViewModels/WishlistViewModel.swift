import Foundation

protocol WishlistViewModelProtocol {
  var searchDelegate: SearchDelegate? { get set }
  func movie(at index: Int) -> RealmMovie
  func getMovies() -> [RealmMovie]
  func loadWishlist()
  func deleteMovie(by id: String)
}

class WishlistViewModel: WishlistViewModelProtocol {
  
  // MARK: - Properties
  
  weak var searchDelegate: SearchDelegate?
  private var dataService: RealmServiceProtocol
  private var moviesDB: [RealmMovie] = []
  
  init(dataService: RealmServiceProtocol) {
    self.dataService = dataService
  }
  
  // MARK: - Public
  
  func getMovies() -> [RealmMovie] {
    return moviesDB
  }
  
  func loadWishlist() {
    dataService.getAllMovies { result in
      switch result {
      case .success(let data):
        print("Movies loaded from db: \(data)")
        self.moviesDB = data
        self.searchDelegate?.reloadTableView()
      case .failure(let error):
        print("Something went wrong: \(error)")
      }
    }
  }
  
  func deleteMovie(by id: String) {
    dataService.deleteMovie(by: id)
  }
  
  func movie(at index: Int) -> RealmMovie {
    moviesDB[index]
  }
}
