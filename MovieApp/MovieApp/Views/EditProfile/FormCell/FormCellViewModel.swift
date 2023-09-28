import Foundation
import Combine

class FormCellViewModel {
    
    // MARK: - Properties
    
    private(set) var placeholder: String
    private(set) var helperText: String
    private(set) var tag: Int
    
    @Published private(set) var initialValue: String = ""
    @Published private(set) var text: String = ""
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(placeholder: String = "", helperText: String = "", initialValue: String = "", tag: Int) {
        self.placeholder = placeholder
        self.helperText = helperText
        self.tag = tag
        self.initialValue = initialValue
    }
    
    // MARK: - Public
    
    func setData(_ value: String) {
        text = value
    }
    
    func setInitialValue(_ value: String) {
        initialValue = value
    }
}
