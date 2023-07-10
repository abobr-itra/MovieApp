import Foundation

protocol MovieModelProtocol {
    
    var title: String { get set }
    var year: String { get set }
    var imdbID: String { get set }
    var type: String { get set }
    var posterUrl: String { get set }
}
