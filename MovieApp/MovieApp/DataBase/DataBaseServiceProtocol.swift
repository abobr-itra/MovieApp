import Foundation

protocol DataBaseServiceProtocol {
    
    func saveData<T: Encodable>(dataModel: T)
    func getData<T: Decodable>(ofType type: T.Type, completion: @escaping (Result<T, Error>) -> ())
}
