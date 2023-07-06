import Foundation

class MoviePageViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = MoviePageViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> MoviePageViewModel {
        let networkService = NetworkService(parser: parser)
        let dataService = RealmService()
        let movieService = MovieService(networkService: networkService)
        return MoviePageViewModel(movieService: movieService, dataService: dataService)
    }
}
