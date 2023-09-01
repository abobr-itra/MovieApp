import UIKit

protocol EditProfileViewModelProtocol {

    var formFields: [FormOption] { get }

    func save()
    func setData(_ text: String, with tag: Int)
}
