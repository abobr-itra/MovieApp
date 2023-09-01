import UIKit

protocol EditProfileViewModelProtocol {

    var formFields: [FormOption] { get }

    func save()
    func textFieldHandler(_ textField: UITextField)
}
