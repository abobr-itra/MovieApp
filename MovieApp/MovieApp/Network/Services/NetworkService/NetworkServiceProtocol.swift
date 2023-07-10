import Foundation

protocol NetworkServiceProtocol {
    
    func getData<T: Decodable>(from url: URL, resultHandler: @escaping (Result<T, RequestError>) -> Void)
}
