import UIKit

protocol EditProfileViewModelProtocol {

    var formFields: [FormOption] { get }

    func save()
    func signOut()
    func setData(_ text: String, with tag: Int)
}
