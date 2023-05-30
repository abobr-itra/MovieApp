import UIKit

struct SettingsSection {
  
  let title: String
  let options: [SettingsOption]
}

struct SettingsOption {
  
  let title: String
  let icon: UIImage?
  let iconBackgroundColor: UIColor
  let handler: (() -> Void)
}
