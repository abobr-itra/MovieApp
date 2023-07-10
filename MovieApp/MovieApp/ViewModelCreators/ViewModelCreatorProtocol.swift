import Foundation

protocol ViewModelCreatorProtocol {
    
    associatedtype ViewModel
    // TODO: Remove NetworkParser parameter
    func factoryMethod(parser: NetworkPaserProtocol) -> ViewModel
}
