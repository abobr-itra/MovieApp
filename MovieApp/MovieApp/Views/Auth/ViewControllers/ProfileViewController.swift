import UIKit

class ProfileViewController: UIViewController {

    // TODO: How to pop back right to setting VC and skip Auth VC
    // TODO: Where to store info that user is authorized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}
