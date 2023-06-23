import UIKit

class SettingsLanguageCell: UITableViewCell {
  
  static let identifier = "SettingsLanguageCell"
  
  private let englishNameLabel: UILabel = UILabel()
  private let localNameLabel: UILabel = UILabel()
  private let selectedImageView: UIImageView = UIImageView()

  override init(style: CellStyle, reuseIdentifier: String?) {
      super.init(style: .default, reuseIdentifier: reuseIdentifier)

      setup()
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)

      setup()
  }

  private func setup() {
      let titleStackView = UIStackView(arrangedSubviews: [ englishNameLabel, localNameLabel ])
      titleStackView.axis = .vertical
      titleStackView.alignment = .leading
      [ titleStackView, selectedImageView ].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
          contentView.addSubview($0)
      }
      NSLayoutConstraint.activate([
          titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
          titleStackView.trailingAnchor.constraint(equalTo: selectedImageView.leadingAnchor, constant: -8),
          titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
          titleStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
          selectedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          selectedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
          selectedImageView.widthAnchor.constraint(equalToConstant: 24),
          selectedImageView.heightAnchor.constraint(equalToConstant: 24),
      ])
      englishNameLabel.textColor = .black
      localNameLabel.textColor = .black
      selectedImageView.image = UIImage(systemName: "checkmark")
      selectedImageView.tintColor = .orange
      selectionStyle = .none
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      selectedImageView.alpha = selected ? 1 : 0
  }

  func configure(title: String?, subtitle: String?) {
      englishNameLabel.text = title?.uppercased()
      localNameLabel.text = subtitle
  }
}
