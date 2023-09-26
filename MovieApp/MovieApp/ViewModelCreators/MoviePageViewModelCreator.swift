import Foundation
import RealmSwift
import Swinject

class MoviePageViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = MoviePageViewModel
    private var dependencyManager: DependencyManager

    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }
    
    func factoryMethod() -> MoviePageViewModel {
        let dataService = dependencyManager.resolver.resolve(RealmServiceProtocol.self)!
        let movieService = dependencyManager.resolver.resolve(MovieServiceProtocol.self)!
        return MoviePageViewModel(movieService: movieService, dataService: dataService)
    }
}
