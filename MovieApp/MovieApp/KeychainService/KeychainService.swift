import Foundation

class KeychainService: KeychainServiceProtocol {
    
    // MARK: - Properties
    let successStatus = 0
    var keyPrefix = ""
    
    init(keyPrefix: String = "") {
        self.keyPrefix = keyPrefix
    }
    
    // MARK: - Public
    
    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool {

        delete(key)
        
        let query: [CFString: Any] = [
            kSecValueData: value,
            kSecAttrAccount: keyWithPrefix(key),
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == successStatus
    }
    
    func get(_ key: String) -> String? {
        let query: [CFString: Any] = [
            kSecAttrAccount: keyWithPrefix(key),
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var ref: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &ref)
        if let data = ref as? Data,
           let value = String(data: data, encoding: .utf8) {
            return value
        }
        return nil
    }

    @discardableResult
    func delete(_ key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecAttrAccount: keyWithPrefix(key),
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == successStatus
    }
    
    // MARK: - Private
    
    private func keyWithPrefix(_ key: String) -> String {
        return "\(keyPrefix)\(key)"
    }
}
