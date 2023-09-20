import Foundation

struct ChatCellModel {
    
    var title: String
    var lastMessage: String
    var image: String
    var isOnline: Bool
    var numberOfUnreadMessages: Int
    var isUnread: Bool { numberOfUnreadMessages > 0 }
}
