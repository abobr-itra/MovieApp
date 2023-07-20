import Foundation
import Combine

protocol NetworkServiceProtocol {

    func getData<T: Decodable>(from url: URL, type: T.Type) -> AnyPublisher<T, RequestError>
}
