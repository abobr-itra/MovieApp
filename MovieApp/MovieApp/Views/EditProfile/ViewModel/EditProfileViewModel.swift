import UIKit
import Combine

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    // MARK: - Properties
    
    private var userData: UserData?
    private let authService = AuthService()
    private let firebaseService = FirebaseDBService()
    
    @Published private var isUserLoaded: Bool = false
    
    var isUserLoadedPublisher: Published<Bool>.Publisher { $isUserLoaded }
    private var subscriptions: Set<AnyCancellable> = []
    
    private(set) var formFieldsModels: [FormCellViewModel] = [
        FormCellViewModel(placeholder: "Name", helperText: "ex. Jhone", tag: 0),
        FormCellViewModel(placeholder: "Surname", helperText: "ex. Doe", tag: 1),
        FormCellViewModel(placeholder: "Avatar URL", helperText: "https://some-url.com", tag: 2)
    ]

    // MARK: - Init
    
    init() {
        loadUser()
        observe()
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
    
    // MARK: - Private
    
    private func observe() {
        formFieldsModels[0].$text
            .sink { self.userData?.firstName = $0 }
            .store(in: &subscriptions)
        formFieldsModels[1].$text
            .sink { self.userData?.secondName = $0 }
            .store(in: &subscriptions)
        formFieldsModels[2].$text
            .sink { self.userData?.avatarUrl = $0 }
            .store(in: &subscriptions)
    }
    
    private func loadUser() {
        firebaseService.getData(ofType: UserData.self) { result in
            switch result {
            case let .success(data):
                self.userData = data
                self.updateFields(with: data)
                self.isUserLoaded = true
            case let .failure(error):
                self.isUserLoaded = false
                self.userData = UserData(id: self.authService.currentUser?.uid ?? "")
                print("Error getData \(error)")
            }
        }
    }
    
    private func updateFields(with data: UserData) {
        formFieldsModels[0].setInitialValue(data.firstName)
        formFieldsModels[1].setInitialValue(data.secondName)
        formFieldsModels[2].setInitialValue(data.avatarUrl)
    }
}

enum TextFieldData: Int {

    case nameField = 0
    case surnameField
    case avatarUrl
}
