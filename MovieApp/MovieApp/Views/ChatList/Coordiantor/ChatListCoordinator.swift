import UIKit

class ChatListCooridnator: ChatListCoordinatorProtocol {

    var dependecyManager: DependencyManager
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, dependecyManager: DependencyManager) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
    }
    
    func start() {
        let chatListVM = ChatListViewModel()
        let chatListVC = ChatListViewController(viewModel: chatListVM)
        navigationController.pushViewController(chatListVC, animated: true)
    }
}
