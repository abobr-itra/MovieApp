import Foundation

protocol NetworkPaserProtocol {
    
    func decode<Value: Decodable>(_ data: Data) -> Result<Value, Error>
}
