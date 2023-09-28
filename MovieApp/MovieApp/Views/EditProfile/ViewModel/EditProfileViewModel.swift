import UIKit
import Combine

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    // MARK: - Properties
    
    private var userData: UserData?
    private let authService: AuthServiceProtocol
    private let databaseService: DataBaseServiceProtocol
    
    @Published private var isUserLoaded: Bool = false
    
    var isUserLoadedPublisher: Published<Bool>.Publisher { $isUserLoaded }
    private var subscriptions: Set<AnyCancellable> = []
    
    private(set) var profileTextFields: [ProfileTextFields] = [
        .firstName(FormCellViewModel(placeholder: "Name", helperText: "ex. Jhone", tag: 0)),
        .secondName(FormCellViewModel(placeholder: "Surname", helperText: "ex. Doe", tag: 1)),
        .avatarUrl(FormCellViewModel(placeholder: "Avatar URL", helperText: "https://some-url.com", tag: 2))
    ]

    // MARK: - Init
    
    init(authService: AuthServiceProtocol, databaseService: DataBaseServiceProtocol) {
        self.authService = authService
        self.databaseService = databaseService
        
        loadUser()
        observe()
    }
    
    // MARK: - Public
    
    func save() {
        guard let userData = userData else { return }
        databaseService.saveData(dataModel: userData)
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
        profileTextFields.forEach { textField in
            switch textField {
            case .firstName(let viewModel):
                viewModel.$text
                    .sink { [weak self] in self?.userData?.firstName = $0 }
                    .store(in: &subscriptions)
            case .secondName(let viewModel):
                viewModel.$text
                    .sink { [weak self] in self?.userData?.secondName = $0 }
                    .store(in: &subscriptions)
            case .avatarUrl(let viewModel):
                viewModel.$text
                    .sink { [weak self] in self?.userData?.avatarUrl = $0 }
                    .store(in: &subscriptions)
            }
        }
    }
    
    private func loadUser() {
        databaseService.getData(ofType: UserData.self) { [weak self] result in
            switch result {
            case let .success(data):
                self?.userData = data
                self?.updateFields(with: data)
                self?.isUserLoaded = true
            case let .failure(error):
                self?.isUserLoaded = false
                self?.userData = UserData(id: self?.authService.currentUser?.uid ?? "")
                print("Error getData \(error)")
            }
        }
    }
    
    private func updateFields(with data: UserData) {
        profileTextFields.forEach { textField in
            switch textField {
            case .firstName(let viewModel):
                viewModel.setInitialValue(data.firstName)
            case .secondName(let viewModel):
                viewModel.setInitialValue(data.secondName)
            case .avatarUrl(let viewModel):
                viewModel.setInitialValue(data.avatarUrl)
            }
        }
    }
}

enum ProfileTextFields {

    case firstName(FormCellViewModel)
    case secondName(FormCellViewModel)
    case avatarUrl(FormCellViewModel)
    
    func associatedValue() -> FormCellViewModel {
        switch self {
        case .firstName(let viewModel):
            return viewModel
        case .secondName(let viewModel):
            return viewModel
        case .avatarUrl(let viewModel):
            return viewModel
        }
    }
}
