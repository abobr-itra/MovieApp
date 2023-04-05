import Foundation
import RealmSwift

enum DataError: String, Error {
  
  case notFound = "Object was not found"
}

protocol RealmServiceProtocol {
  
  func saveObject(_ object: Object)
  func getMovie(by id: String, _ completion: @escaping ((Result<RealmMovie, DataError>) -> Void))
  func deleteMovie(by id: String)
}

class RealmService: RealmServiceProtocol {
  
  // TODO: Add error handling
  
  //  private var realm: Realm
  //
  //  init() {
  //    realm = try? Realm() // ?? Better solution
  //  }
  
  // MARK: Public
  
  func saveObject(_ object: Object) {
    DispatchQueue.global().async {
      guard let realm = try? Realm() else { return }
      print("🌎 Start saving \(object)")
      try? realm.write {
        print("🌎 Adding \(object) to realm database")
        realm.add(object, update: .modified)
      }
    }
  }
  
  func getMovie(by id: String, _ completion: @escaping ((Result<RealmMovie, DataError>) -> Void)) {
    DispatchQueue.global().async {
      guard let realm = try? Realm() else { return }
      let movie = realm.object(ofType: RealmMovie.self, forPrimaryKey: id)
      if let movie = movie {
        completion(.success(movie))
      } else {
        completion(.failure(.notFound))
      }
    }
  }
  
  func getAllMovies(completion: @escaping ((Result<[RealmMovie], DataError>) -> Void)) {
      DispatchQueue.global().async {
          guard let realm = try? Realm() else { return }
          let movies = realm.objects(RealmMovie.self)
          if !movies.isEmpty {
              completion(.success(Array(movies)))
          } else {
              completion(.failure(.notFound))
          }
      }
  }

  
  func deleteMovie(by id: String) {
    DispatchQueue.global().async {
      print("🌎 Start deleting \(id)")
      guard let realm = try? Realm() else { return }
      try? realm.write {
        let movie = realm.objects(RealmMovie.self).where {
          $0.imdbID == id
        }
        print("🌎 Trying to delete \(movie)")
        realm.delete(movie)
      }
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
  
  // MARK: Private
  
  private func objectExist(id: String, realm: Realm) -> Bool {
    return realm.object(ofType: RealmMovie.self, forPrimaryKey: id) != nil
  }
}
