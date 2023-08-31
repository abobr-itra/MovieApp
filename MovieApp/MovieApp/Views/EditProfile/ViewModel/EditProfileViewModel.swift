import Foundation

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    // MARK: - Properties
    
    private(set) var formFields: [FormOption] = [
        FormOption(placeholder: "Name", helperText: "ex. Jhone"),
        FormOption(placeholder: "Surname", helperText: "ex. Doe"),
        FormOption(placeholder: "Mobile number", helperText: "375*********")
    ]
    
    // MARK: - Public
}
