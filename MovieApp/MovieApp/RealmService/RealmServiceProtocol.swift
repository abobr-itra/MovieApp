import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    
    func saveObject<T: Object>(ofType type: T.Type, object: T, primaryKey: Int)
    func getObject<T: Object>(ofType type: T.Type, by id: String, completion: @escaping (Result<T, DataError>) -> Void)
    func getAllObjects<T: Object>(ofType type: T.Type, completion: @escaping (Result<[T], DataError>) -> Void)
    func deleteObject<T: Object>(ofType type: T.Type, where isIncluded: @escaping (T) -> Bool)
}
