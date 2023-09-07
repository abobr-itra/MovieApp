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
            .child("users/\(uid)/user_data")
        return ref
    }()
    
    // MARK: - Public
    
    func saveData<T: Encodable>(dataModel: T) {
        guard let databasePath = databasePath else { return }
        
        do {
            let data = try encoder.encode(dataModel)
            let json = try JSONSerialization.jsonObject(with: data)
            databasePath.childByAutoId()
                .setValue(json)
        } catch {
            print("an error occurred", error)
        }
    }
    
    func getData<T: Decodable>(ofType type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let databasePath = databasePath else { return }
        
        databasePath
            .observe(.childAdded) { [weak self] snapshot in
                guard let self = self,
                      var json = snapshot.value as? [String: Any] else { return }
                json["id"] = snapshot.key
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
