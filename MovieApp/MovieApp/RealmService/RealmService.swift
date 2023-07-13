import Foundation
import RealmSwift

class RealmService: RealmServiceProtocol {

    // MARK: - Public
    
    func saveObject(_ object: Object) {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else { return }
            print("🌎 Start saving \(object)")
            try? realm.write {
                print("🌎 Adding \(object) to realm database")
                realm.add(object, update: .modified)
            }
        }
    }

    func getObject<T: Object>(by id: String, completion: @escaping (Result<T, DataError>) -> Void) {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else { return }
            let object = realm.object(ofType: T.self, forPrimaryKey: id)
            if let object = object {
                completion(.success(object))
            } else {
                completion(.failure(.notFound))
            }
        }
    }

    func getAllObjects<T: Object>(ofType: T.Type, completion: @escaping (Result<[T], DataError>) -> Void) {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else { return }
            let objects = realm.objects(T.self)
            if !objects.isEmpty {
                completion(.success(Array(objects)))
            } else {
                completion(.failure(.notFound))
            }
        }
    }

    func deleteObject<T: Object>(ofType: T.Type, where isIncluded: @escaping (T) -> Bool) {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else { return }
            try? realm.write({
                guard let object = realm.objects(T.self).first(where: isIncluded) else {
                    print("Failed to delete")
                    return
                }
                realm.delete(object)
            })
        }
    }
    
    // TODO: Create func that checks if data need to be updated (by hash)
    
    func needsUpdate(object: Object, hashValue: Int) -> Bool {
        
        guard let realm = try? Realm() else { return false }
        
        let currentHashValue = object.hashValue
        if currentHashValue != hashValue {
            let isObjectInRealm = realm.isInWriteTransaction && realm.object(ofType: type(of: object),
                                                                             forPrimaryKey: Object.primaryKey) != nil
            return isObjectInRealm
        } else {
            return false
        }
    }
    
    // MARK: - Private
    
    private func objectExist(id: String, realm: Realm) -> Bool {
        realm.object(ofType: RealmMovie.self, forPrimaryKey: id) != nil
    }
}
