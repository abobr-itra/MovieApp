import Foundation
import RealmSwift
import Swinject

class MoviePageViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = MoviePageViewModel
    
    func factoryMethod() -> MoviePageViewModel {
        let dataService = Container.shared.resolve(RealmServiceProtocol.self)!
        let movieService = Container.shared.resolve(MovieServiceProtocol.self)!
        return MoviePageViewModel(movieService: movieService, dataService: dataService)
    }
}
