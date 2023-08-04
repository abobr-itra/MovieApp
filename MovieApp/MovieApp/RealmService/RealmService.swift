import Foundation
import RealmSwift

class RealmService: RealmServiceProtocol {    
    
    // MARK: Properties
    
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    // MARK: - Public
    
    func saveObject<T: Object>(ofType type: T.Type, object: T, primaryKey: String) {
        if realm?.object(ofType: type.self, forPrimaryKey: primaryKey) == nil {
            try? realm?.write {
                print("🌎 Adding \(object) to realm database")
                realm?.add(object, update: .modified)
            }
        }
    }
    
    func updateObject<T: Object>(ofType type: T.Type, where isIncluded: (T) -> Bool, with block: (_ object: T) -> ()) {
        guard let object = realm?.objects(type.self).first(where: isIncluded) else { return }
        try? realm?.write({ block(object) })
    }

    func getObject<T: Object>(ofType type: T.Type, by id: String, completion: @escaping (Result<T, DataError>) -> Void) {
        let object = realm?.object(ofType: type.self, forPrimaryKey: id)
        if let object = object {
            completion(.success(object))
        } else {
            completion(.failure(.notFound))
        }
    }

    func getAllObjects<T: Object>(ofType type: T.Type, completion: @escaping (Result<[T], DataError>) -> Void) {
        guard let objects = realm?.objects(type.self) else { return }
        print("Objects \(objects)")
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
