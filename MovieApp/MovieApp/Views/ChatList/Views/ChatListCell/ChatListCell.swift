import UIKit

class ChatListCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "ChatListCell"
    
    private var contactTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = LocalConstants.contactTitleColor
        label.font = Constants.Fonts.plusJakartMedium
        return label
    }()
    
    private var lastMessageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = LocalConstants.messageColor
        label.font = Constants.Fonts.plusJakartRegular
        return label
    }()
    
    private var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = LocalConstants.imageSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = LocalConstants.dateColor
        label.font = Constants.Fonts.plusJakartRegular
        return label
    }()
    
    private var unreadMessagesView: UnreadMessagesIndicator = {
        let indicator = UnreadMessagesIndicator(frame: .zero)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    private enum LocalConstants {
        
        static let verticalSpacing: CGFloat = 8
        static let horizontalSpaing: CGFloat = 16
        static let imageSize: CGFloat = 48
        static let dateIndicatorSpacing: CGFloat = 6
        
        static let messageColor = UIColor(red: 0.308, green: 0.368, blue: 0.483, alpha: 1)
        static let contactTitleColor = UIColor(red: 0.106, green: 0.102, blue: 0.342, alpha: 1)
        static let dateColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        static let selectionColor = UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 0.1)
        
        static let cellInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    // MARK: - Lifecycle
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? LocalConstants.selectionColor : Constants.Colors.clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: LocalConstants.cellInset)
    }

    // MARK: - Public
    
    func setup(from model: ChatCellModel) {
        setupCellUI()
        setupView()
        setupConstraints()
        
        contactTitle.text = model.title
        lastMessageTitle.text = model.lastMessage
        dateLabel.text = "Yesterday"
        unreadMessagesView.setNumber(model.numberOfUnreadMessages)
        unreadMessagesView.isHidden = model.isUnread
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.addSubview(contactTitle)
        contentView.addSubview(lastMessageTitle)
        contentView.addSubview(contactImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(unreadMessagesView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contactImageView.heightAnchor.constraint(equalToConstant: LocalConstants.imageSize),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LocalConstants.horizontalSpaing),
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: LocalConstants.verticalSpacing),
            contactImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -LocalConstants.verticalSpacing),
        ])
        
        NSLayoutConstraint.activate([
            contactTitle.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: LocalConstants.horizontalSpaing),
            contactTitle.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -LocalConstants.horizontalSpaing),
            contactTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: LocalConstants.verticalSpacing),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LocalConstants.horizontalSpaing),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: LocalConstants.verticalSpacing),
        ])
        
        NSLayoutConstraint.activate([
            lastMessageTitle.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: LocalConstants.horizontalSpaing),
            lastMessageTitle.topAnchor.constraint(equalTo: contactTitle.bottomAnchor, constant: LocalConstants.verticalSpacing),
            lastMessageTitle.trailingAnchor.constraint(equalTo: self.unreadMessagesView.leadingAnchor, constant: -LocalConstants.horizontalSpaing),
        ])
        
        NSLayoutConstraint.activate([
            unreadMessagesView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: LocalConstants.dateIndicatorSpacing),
            unreadMessagesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LocalConstants.horizontalSpaing),
        ])
    }
    
    private func setupCellUI() {
        selectionStyle = .none
        contentView.layer.cornerRadius = LocalConstants.imageSize / 2
        self.setNeedsLayout()
    }
}
