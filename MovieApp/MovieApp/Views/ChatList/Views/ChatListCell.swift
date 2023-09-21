import UIKit

class ChatListCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "ChatListCell"
    
    private var contactTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.106, green: 0.102, blue: 0.342, alpha: 1)
        label.font = Constants.Fonts.plusJakartMedium
        return label
    }()
    
    private var lastMessageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.308, green: 0.368, blue: 0.483, alpha: 1)
        label.font = Constants.Fonts.plusJakartRegular
        return label
    }()
    
    private var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        label.font = Constants.Fonts.plusJakartRegular
        return label
    }()
    
    private var unreadMessagesView: UnreadMessagesIndicator = {
        let indicator = UnreadMessagesIndicator(frame: .zero)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: - Lifecycle
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor(red: 0.184, green: 0.502, blue: 0.929, alpha: 0.1) : Constants.Colors.clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }

    // MARK: - Public
    
    func setup(from model: ChatCellModel) {
        setupCellUI()
        setupView()
        setupConstraints()
        
        contactTitle.text = model.title
        lastMessageTitle.text = model.lastMessage
        dateLabel.text = "Yesterday"
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.addSubview(contactTitle)
        contentView.addSubview(lastMessageTitle)
        contentView.addSubview(contactImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(unreadMessagesView)
        unreadMessagesView.setNumber(5)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contactImageView.heightAnchor.constraint(equalToConstant: 48),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            contactImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            contactTitle.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 16),
            contactTitle.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -16),
            contactTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            lastMessageTitle.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 16),
            lastMessageTitle.topAnchor.constraint(equalTo: contactTitle.bottomAnchor, constant: 8),
            lastMessageTitle.trailingAnchor.constraint(equalTo: self.unreadMessagesView.leadingAnchor, constant: -50),
            lastMessageTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            unreadMessagesView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            unreadMessagesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupCellUI() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 8
    }
}
