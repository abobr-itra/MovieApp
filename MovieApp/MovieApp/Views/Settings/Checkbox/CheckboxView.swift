import Foundation
import UIKit

class CheckboxView: UIView {
  
  // MARK: - Properties
  
  private var isChecked: Bool = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.borderWidth = 0.5
    layer.borderColor = UIColor.secondaryLabel.cgColor
    layer.cornerRadius = frame.size.width / 2
    backgroundColor = .systemBackground
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    layer.backgroundColor = UIColor.secondaryLabel.cgColor
  }
  
  // MARK: - Public
  
  func toggle() {
    isChecked.toggle()
    backgroundColor = isChecked ? .systemBlue: .systemBackground
  }
}
