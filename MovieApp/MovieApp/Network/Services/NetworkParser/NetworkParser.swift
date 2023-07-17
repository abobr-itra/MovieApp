import Foundation

class NetworkParser: NetworkPaserProtocol {
    
    func decode<Value: Decodable>(_ data: Data) -> Result<Value, Error> {
        do {
            let value = try JSONDecoder().decode(Value.self, from: data)
            return .success(value)
        } catch {
            return .failure(error)
        }
    }
}
