import UIKit

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    // MARK: - Properties
    
    private var userData = UserData()
    private let authService = AuthService()
    private let firebaseService = FirebaseDBService()
    
    private(set) var formFields: [FormOption] = [
        FormOption(placeholder: "Name", helperText: "ex. Jhone"),
        FormOption(placeholder: "Surname", helperText: "ex. Doe"),
        FormOption(placeholder: "Mobile number", helperText: "375*********")
    ]
    
    // MARK: - Public
    
    func save() {
        print("User Data : \(userData)")
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
            userData.firstName = text
        case TextFieldData.surnameField.rawValue:
            userData.secondName = text
        case TextFieldData.numberField.rawValue:
            userData.number = text
        default:
            print("Wrong tag❌")
        }
    }
}

enum TextFieldData: Int {

    case nameField = 0
    case surnameField
    case numberField
}
