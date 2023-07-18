import UIKit

protocol RefreshableViewControllerProtocol: UIViewController {
    
    var spinner: SpinnerViewController { get set }
    func showSpinner(_ isLoading: Bool)
}

extension RefreshableViewControllerProtocol {
    
    func showSpinner(_ isLoading: Bool) {
        if isLoading {
            addSpinner()
        } else {
            removeSpinner()
        }
    }
    
    private func addSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    private func removeSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}
