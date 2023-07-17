import Foundation
import RealmSwift

class MoviePageViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = MoviePageViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> MoviePageViewModel {
        let realm = try? Realm()
        let dataService = RealmService(realm: realm)

        let networkService = NetworkService(parser: parser)
        let movieService = MovieService(networkService: networkService)
        return MoviePageViewModel(movieService: movieService, dataService: dataService)
    }
}
