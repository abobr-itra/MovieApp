import Foundation

protocol NetworkPaserProtocol {
  func decode<Value: Decodable>(_ data: Data) -> Result<Value, Error>
}

class NetworkParser: NetworkPaserProtocol {
  func decode<Value: Decodable>(_ data: Data) -> Result<Value, Error> {
    do {
      let value = try JSONDecoder().decode(Value.self, from: data) // ?? вынести decoder как отдельную переменную
      return .success(value)
    } catch {
      print("Some error occur during decoding")
      return .failure(error)
    }
  }
}
