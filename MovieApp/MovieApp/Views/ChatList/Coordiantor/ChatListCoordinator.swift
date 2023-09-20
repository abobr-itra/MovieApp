import UIKit

class ChatListCooridnator: ChatListCoordinatorProtocol {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let chatListVM = ChatListViewModel()
        let chatListVC = ChatListViewController(viewModel: chatListVM)
        navigationController.pushViewController(chatListVC, animated: true)
    }
}
