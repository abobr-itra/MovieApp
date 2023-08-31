import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: EditProfileViewModelProtocol?
    
    private let formTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FormCell.self, forCellReuseIdentifier: FormCell.identifier)
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        return tableView
    }()
    
    fileprivate struct Constants {
        
        static let cellHeight: CGFloat = 68
        static let cellWidth: CGFloat = 200
    }
    
    // MARK: - Init
    
    convenience init(viewModel: EditProfileViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(formTableView)
        formTableView.delegate = self
        formTableView.dataSource = self
        let bottomOffset = view.frame.height - ((Constants.cellHeight + 40) * CGFloat((viewModel?.formFields.count ?? 0)))
        formTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        formTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomOffset ).isActive = true
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
        cell.setup(placeholder: field.placeholder,
                   helperText: field.helperText,
                   width: Constants.cellWidth,
                   height: Constants.cellHeight,
                   tag: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FormCell else {
            return
        }
        cell.focus()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}
