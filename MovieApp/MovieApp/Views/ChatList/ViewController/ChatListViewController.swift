import UIKit

class ChatListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var chatListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatListCell.self,
                           forCellReuseIdentifier: ChatListCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Properties
    
    private var viewModel: ChatListViewModelProtocol? // ?? (any ChatListViewModelProtocol)?
    
    // MARK: - Init
    
    convenience init(viewModel: ChatListViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(chatListTableView)
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.frame = view.bounds
    }
}

extension ChatListViewController: UITableViewDelegate {
    
}

extension ChatListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70 // ?? should be 64
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.chats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatModel = viewModel?.chats[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier, for: indexPath) as? ChatListCell else {
            return UITableViewCell()
        }
        cell.setup(from: chatModel)
        return cell
    }
}
