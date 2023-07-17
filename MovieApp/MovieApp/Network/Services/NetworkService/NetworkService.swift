import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    
    private let parser: NetworkPaserProtocol
    
    init(parser: NetworkPaserProtocol) {
        self.parser = parser
    }
    
    // MARK: - Public

    func getData<T: Decodable>(from url: URL, type: T.Type) -> AnyPublisher<T, RequestError> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { [weak self] output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else { throw RequestError.serverError }
                
                guard let decodedData: Result<T, Error> = self?.parser.decode(output.data) else {
                    throw RequestError.dataDecodingError
                }
                switch decodedData {
                case .failure:
                    throw RequestError.dataDecodingError
                case .success(let data):
                    return data
                }
            }
            .mapError { error in
                switch error {
                case is DecodingError:
                    return RequestError.dataDecodingError
                case is URLError:
                    return RequestError.serverError
                default:
                    return RequestError.noData
                }
            }
            .eraseToAnyPublisher()
    }
}
