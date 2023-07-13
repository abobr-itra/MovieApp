import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    
    func saveObject(_ object: Object)

    func getObject<T: Object>(by id: String, completion: @escaping (Result<T, DataError>) -> Void)
    func getAllObjects<T: Object>(ofType: T.Type, completion: @escaping (Result<[T], DataError>) -> Void)
    func deleteObject<T: Object>(ofType: T.Type, where isIncluded: @escaping (T) -> Bool)
}
