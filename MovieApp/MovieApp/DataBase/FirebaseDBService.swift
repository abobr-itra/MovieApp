import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseDBService {
    
    // MARK: - Properties
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private lazy var databasePath: DatabaseReference? = {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        let ref = Database.database()
            .reference()
            .child("users/\(uid)")
        return ref
    }()
    
    // MARK: - Public
    
    func saveData<T: Encodable>(dataModel: T) {
        guard let databasePath = databasePath else { return }
        do {
            let data = try encoder.encode(dataModel)
            let json = try JSONSerialization.jsonObject(with: data)
            databasePath
                .child("/user_data")
                .setValue(json)
        } catch {
            print("an error occurred", error)
        }
    }
    
    func getData<T: Decodable>(ofType type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let databasePath = databasePath else { return }
        databasePath
            .child("/user_data")
            .getData { [weak self] _, snapshot in
                guard let self = self,
                      let snapshot = snapshot,
                      var json = snapshot.value as? [String: Any] else { return }
                json["id"] = Auth.auth().currentUser?.uid ?? ""
                do {
                    let modelData = try JSONSerialization.data(withJSONObject: json)
                    let data = try self.decoder.decode(T.self, from: modelData)
                    completion(.success(data))
                } catch {
                    print("an error occurred ", error)
                    completion(.failure(error))
                }
            }
    }
}
