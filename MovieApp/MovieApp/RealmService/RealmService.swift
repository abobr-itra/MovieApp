import Foundation
import RealmSwift

class RealmService: RealmServiceProtocol {
    
    // MARK: Properties
    
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    // MARK: - Public
    
    func saveObject(_ object: Object) {
        print("🌎 Start saving \(object)")
        try? realm?.write {
            print("🌎 Adding \(object) to realm database")
            realm?.add(object, update: .modified)
        }
    }

    func getObject<T: Object>(by id: String, completion: @escaping (Result<T, DataError>) -> Void) {
        let object = realm?.object(ofType: T.self, forPrimaryKey: id)
        if let object = object {
            completion(.success(object))
        } else {
            completion(.failure(.notFound))
        }
    }

    func getAllObjects<T: Object>(ofType: T.Type, completion: @escaping (Result<[T], DataError>) -> Void) {
        guard let objects = realm?.objects(T.self) else { return }
        if !objects.isEmpty {
            completion(.success(Array(objects)))
        } else {
            completion(.failure(.notFound))
        }
    }

    func deleteObject<T: Object>(ofType: T.Type, where isIncluded: @escaping (T) -> Bool) {
        try? realm?.write {
            guard let object = realm?.objects(T.self).first(where: isIncluded) else {
                print("Failed to delete")
                return
            }
            realm?.delete(object)
        }
    }
}
