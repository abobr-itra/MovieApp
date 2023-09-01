import UIKit

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    // MARK: - Properties
    
    private var userData: UserData?
    
    private(set) var formFields: [FormOption] = [
        FormOption(placeholder: "Name", helperText: "ex. Jhone"),
        FormOption(placeholder: "Surname", helperText: "ex. Doe"),
        FormOption(placeholder: "Mobile number", helperText: "375*********")
    ]
    
    // MARK: - Public
    
    func save() {
        print(userData)
    }
    
    @objc
    func textFieldHandler(_ textField: UITextField) {
        print("TextField✅", textField.text)
    }
}
