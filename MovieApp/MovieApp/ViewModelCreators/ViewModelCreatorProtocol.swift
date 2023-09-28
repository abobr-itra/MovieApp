import Foundation

protocol ViewModelCreatorProtocol {
    
    associatedtype ViewModel

    func factoryMethod() -> ViewModel
}
