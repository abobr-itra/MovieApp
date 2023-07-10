import Foundation
import Combine

protocol NetworkServiceProtocol {
    
    func getData<T: Decodable>(from url: URL, resultHandler: @escaping (Result<T, RequestError>) -> Void)
    func getData<T: Decodable>(from url: URL, type: T.Type) -> AnyPublisher<T, RequestError>
}
