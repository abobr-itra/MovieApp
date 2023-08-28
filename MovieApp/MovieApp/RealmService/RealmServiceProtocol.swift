import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    
    func saveObject<T: Object>(ofType type: T.Type, object: T, primaryKey: String)
    func getObject<T: Object>(ofType type: T.Type, by id: String, completion: @escaping (Result<T, DataError>) -> Void)
    func updateObject<T: Object>(ofType type: T.Type, where isIncluded: (T) -> Bool, with block: (_ object: T) -> ())
    func getAllObjects<T: Object>(ofType type: T.Type, completion: @escaping (Result<[T], DataError>) -> Void)
    func deleteObject<T: Object>(ofType type: T.Type, where isIncluded: @escaping (T) -> Bool)
}
