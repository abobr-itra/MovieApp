import UIKit

protocol EditProfileViewModelProtocol {

    var isUserLoadedPublisher: Published<Bool>.Publisher { get }
    var formFieldsModels: [FormCellViewModel] { get }

    func save()
    func signOut()
}
