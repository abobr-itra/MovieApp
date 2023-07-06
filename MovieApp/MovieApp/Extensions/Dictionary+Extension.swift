import Foundation

extension Dictionary where Value: Equatable {
    
    func someKey(forValue val: Value) -> Key? {
        first(where: { $1 == val })?.key
    }
}
