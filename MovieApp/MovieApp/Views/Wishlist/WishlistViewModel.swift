import Foundation

protocol WishlistViewModelProtocol {

  var onDataLoaded: (() -> Void)? { get set }
  func movie(at index: Int) -> RealmMovie
  func getMovies() -> [RealmMovie]
  func loadWishlist()
  func deleteMovie(by id: String)
}

class WishlistViewModel: WishlistViewModelProtocol {
  
  // MARK: - Properties
  
  var onDataLoaded: (() -> Void)?
  
  private var dataService: RealmServiceProtocol
  private(set) var moviesDB: [RealmMovie] = []
  
  init(dataService: RealmServiceProtocol) {
    self.dataService = dataService
  }
  
  // MARK: - Public
  
  func getMovies() -> [RealmMovie] {
    moviesDB
  }
  
  func loadWishlist() {
    DispatchQueue.global().async {
      self.dataService.getAllMovies { result in
        switch result {
        case .success(let data):
          print("Movies loaded from db: \(data)")
          self.moviesDB = data
        //  self.searchDelegate?.reloadTableView()
          self.onDataLoaded?()
        case .failure(let error):
          print("Something went wrong: \(error)")
        }
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
