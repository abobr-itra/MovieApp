import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: EditProfileViewModelProtocol?
    
    private let formTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Init
    
    convenience init(viewModel: EditProfileViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    // MARK: - Private
    
    private func setupTableView() {
        view.addSubview(formTableView)
        formTableView.delegate = self
        formTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        formTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        formTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        formTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - Extensions

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.formFields.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let field = viewModel?.formFields[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: FormCell.identifier, for: indexPath) as? FormCell else {
            return UITableViewCell()
        }
        cell.setup(placeholder: field.placeholder, helperText: field.helperText, width: 200, height: 68)
        return cell
    }
}
