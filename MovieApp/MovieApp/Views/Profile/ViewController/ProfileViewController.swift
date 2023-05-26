import UIKit

class ProfileViewController: UIViewController {
  
  private var viewModel: ProfileViewModelProtocol?
  
  convenience init(viewModel: ProfileViewModelProtocol?) {
    self.init(nibName: nil, bundle: nil)
    
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
