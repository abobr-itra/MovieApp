import Foundation

protocol WishlistViewModelProtocol {
  func getMovies() -> [RealmMovie]
  func loadWishlist()
  func deleteMovie(by id: String)
}

class WishlistViewModel: WishlistViewModelProtocol {
  
  // MARK: - Properties
  
  private var dataService: RealmServiceProtocol
  var moviesDB: [RealmMovie] = []
  
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
        print("Movies loaded from db")
        self.moviesDB = data
      case .failure(let error):
        print("Something went wrong: \(error)")
      }
    }
  }
  
  func deleteMovie(by id: String) {
    dataService.deleteMovie(by: id)
  }
}
