import UIKit

protocol EditProfileViewModelProtocol {

    var isUserLoadedPublisher: Published<Bool>.Publisher { get }
    var profileTextFields: [ProfileTextFields] { get }

    func save()
    func signOut()
}
