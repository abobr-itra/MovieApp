import Foundation

protocol NetworkServiceProtocol {
  
}

class NetworkService: NetworkServiceProtocol {
  // MARK: Properties
  
  private let parser: NetworkPaserProtocol
  
  init(parser: NetworkPaserProtocol) {
    self.parser = parser
  }
  
  // MARK: Public
  
  func getData<T: Decodable>(from url: URL, resultHandler: @escaping (Result<T, RequestError>) -> Void) {
    let urlRequest = URLRequest(url: url)
    let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      guard error == nil else {
        resultHandler(.failure(.clientError))
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
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
  
  // MARK: Private
  
}
