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
    
    private var navTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.106, green: 0.102, blue: 0.342, alpha: 1)
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: 18)
        label.text = "Recent Chats"
        return label
    }()

    // MARK: - Properties
    
    private var viewModel: ChatListViewModelProtocol?
    
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
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navTitleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "chat_search"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.31, green: 0.37, blue: 0.48, alpha: 1)
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
        70
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
