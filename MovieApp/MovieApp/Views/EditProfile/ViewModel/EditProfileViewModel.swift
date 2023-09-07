import UIKit
import Combine

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    // MARK: - Properties
    
    private var userData: UserData?
    private let authService = AuthService()
    private let firebaseService = FirebaseDBService()
    
    @Published private var isUserLoaded: Bool = false
    
    var isUserLoadedPublisher: Published<Bool>.Publisher { $isUserLoaded }
    
    private(set) var formFields: [FormOption] = [
        FormOption(placeholder: "Name", helperText: "ex. Jhone"),
        FormOption(placeholder: "Surname", helperText: "ex. Doe"),
        FormOption(placeholder: "Avatar URL", helperText: "https://some-url.com")
    ]
    
    // MARK: - Init
    
    init() {
        loadUser()
    }
    
    // MARK: - Public
    
    func save() {
        guard let userData = userData else { return }
        firebaseService.saveData(dataModel: userData)
    }
    
    func signOut() {
        do {
            try authService.signOut()
        } catch {
            print("SignOut error \(error)")
        }
    }
    
    func setData(_ text: String, with tag: Int) {
        switch tag {
        case TextFieldData.nameField.rawValue:
            userData?.firstName = text
        case TextFieldData.surnameField.rawValue:
            userData?.secondName = text
        case TextFieldData.avatarUrl.rawValue:
            userData?.avatarUrl = text
        default:
            print("Wrong tag❌")
        }
    }
    
    func getData(by tag: Int) -> String {
        var text: String?
        switch tag {
        case TextFieldData.nameField.rawValue:
            text = userData?.firstName
        case TextFieldData.surnameField.rawValue:
            text = userData?.secondName
        case TextFieldData.avatarUrl.rawValue:
            text = userData?.avatarUrl
        default:
            text = ""
        }
        return text ?? ""
    }
    
    // MARK: - Private
    
    private func loadUser() {
        firebaseService.getData(ofType: UserData.self) { result in
            switch result {
            case let .success(data):
                self.userData = data
                self.isUserLoaded = true
            case let .failure(error):
                self.isUserLoaded = false
                print("Error getData \(error)")
            }
        }
    }
}

enum TextFieldData: Int {

    case nameField = 0
    case surnameField
    case avatarUrl
}
