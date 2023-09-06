import Foundation

protocol KeychainServiceProtocol {
    
    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool
    func get(_ key: String) -> String?
    func delete(_ key: String) -> Bool
}
