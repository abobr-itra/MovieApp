import UIKit

protocol EditProfileViewModelProtocol {
    
    
    var isUserLoadedPublisher: Published<Bool>.Publisher { get }
    var formFields: [FormOption] { get }

    func save()
    func signOut()

    func setData(_ text: String, with tag: Int)
    func getData(by tag: Int) -> String
}
