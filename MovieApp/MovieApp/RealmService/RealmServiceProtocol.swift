import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    
    func saveObject(_ object: Object)
    func getMovie(by id: String, _ completion: @escaping ((Result<RealmMovie, DataError>) -> Void))
    func deleteMovie(by id: String)
    func getAllMovies(completion: @escaping ((Result<[RealmMovie], DataError>) -> Void))
}
