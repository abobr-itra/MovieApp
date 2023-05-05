import UIKit

protocol RefreshableViewController: UIViewController  {
  
  var spinner: SpinnerViewController { get set }
  func showSpinner()
  func hideSpinner()
}

extension RefreshableViewController {
  
  func showSpinner() {
    addChild(spinner)
    spinner.view.frame = view.frame
    view.addSubview(spinner.view)
    spinner.didMove(toParent: self)
  }
  
  func hideSpinner() {
    spinner.willMove(toParent: nil)
    spinner.view.removeFromSuperview()
    spinner.removeFromParent()
  }
}
