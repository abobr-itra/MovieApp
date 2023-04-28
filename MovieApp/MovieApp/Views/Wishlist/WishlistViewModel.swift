import Foundation

protocol WishlistViewModelProtocol: MovieViewModelProtocol {

  var onDataLoaded: (() -> Void)? { get set }
  func loadWishlist()
  func deleteMovie(by id: String)
}

class WishlistViewModel: MovieViewModelProtocol, WishlistViewModelProtocol {
  
  // MARK: - Properties
  
  var onDataLoaded: (() -> Void)?
  
  private var dataService: RealmServiceProtocol
  private(set) var moviesDB: [RealmMovie] = []
  
  init(dataService: RealmServiceProtocol) {
    self.dataService = dataService
  }
  
  // MARK: - Public
  
  func loadWishlist() {
    DispatchQueue.global().async {
      self.dataService.getAllMovies { result in
        switch result {
        case .success(let data):
          print("Movies loaded from db: \(data)")
          self.moviesDB = data
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
  
  func movie(at index: Int) -> MovieModelProtocol {
    moviesDB[index]
  }
  
  func moviesCount() -> Int {
    moviesDB.count
  }
}
