import UIKit

class CheckboxButton: UIView {
  
  // MARK: - Properties
  
  public var isChecked: Bool = false
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.isHidden = false
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .white
    imageView.image = UIImage(systemName: "checkmark")
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemGreen
    addSubview(imageView)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageView.frame = CGRect(x: 0,
                             y: 0,
                             width: frame.size.width,
                             height: frame.size.height)
  }
  
  // MARK: - Public
  
  public func toggle() {
    isChecked.toggle()
    imageView.isHidden = !isChecked
  }
}
