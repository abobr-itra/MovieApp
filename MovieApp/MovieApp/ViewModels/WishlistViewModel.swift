import Foundation

protocol WishlistViewModelProtocol {
  
}

class WishlistViewModel: WishlistViewModelProtocol {
  
  // MARK: - Properties
  
  private var dataService: RealmServiceProtocol
  
  init(dataService: RealmServiceProtocol) {
    self.dataService = dataService
  }
  
  // MARK: - Public
  
  func loadWishlist() {
    
  }
}
