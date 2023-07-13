import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    
    private let parser: NetworkPaserProtocol
    
    init(parser: NetworkPaserProtocol) {
        self.parser = parser
    }
    
    // MARK: - Public
    
    func getData<T: Decodable>(from url: URL, resultHandler: @escaping (Result<T, RequestError>) -> Void) {
        let urlRequest = URLRequest(url: url)
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }
            
            guard response is HTTPURLResponse else {
                resultHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
            
            let decodedData: Result<T, Error> = self.parser.decode(data)
            switch decodedData {
            case .failure(let error):
                print("Error occured: ", error)
                resultHandler(.failure(.dataDecodingError))
            case .success(let data):
                resultHandler(.success(data))
            }
        }
        urlTask.resume()
    }

    func getData<T: Decodable>(from url: URL, type: T.Type) -> AnyPublisher<T, RequestError> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else { throw RequestError.serverError }
                
                let decodedData: Result<T, Error> = self.parser.decode(output.data)
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
