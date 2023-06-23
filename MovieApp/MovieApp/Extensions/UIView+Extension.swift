import UIKit

extension UIView {
  
  func updateSemanticContentAttribute(_ semanticContentAttribute: UISemanticContentAttribute) {
      subviews.forEach { $0.updateSemanticContentAttribute(semanticContentAttribute) }

      let nonChangeableAlignments: [NSTextAlignment] = [ .justified, .center ]
      let alignment: NSTextAlignment = semanticContentAttribute == .forceRightToLeft ? .right : .left

      switch (self, self.semanticContentAttribute) {
          case (_, .playback), (_, .spatial):
              break
          case (let textField as UITextField, _) where !nonChangeableAlignments.contains(textField.textAlignment):
              if textField.textAlignment != alignment {
                  textField.textAlignment = alignment
              }

              if self.semanticContentAttribute != semanticContentAttribute {
                  self.semanticContentAttribute = semanticContentAttribute
              }
          case (let textView as UITextView, _) where !nonChangeableAlignments.contains(textView.textAlignment):
              if textView.textAlignment != alignment {
                  textView.textAlignment = alignment
              }

              if self.semanticContentAttribute != semanticContentAttribute {
                  self.semanticContentAttribute = semanticContentAttribute
              }
          case (let label as UILabel, _) where !nonChangeableAlignments.contains(label.textAlignment):
              if label.textAlignment != alignment {
                  label.textAlignment = alignment
              }

              if self.semanticContentAttribute != semanticContentAttribute {
                  self.semanticContentAttribute = semanticContentAttribute
              }
          default:
              if self.semanticContentAttribute != semanticContentAttribute {
                  self.semanticContentAttribute = semanticContentAttribute
              }
      }
  }

  func updateSemanticContentAttribute(localization: String) {
      let isRTL = Locale.characterDirection(forLanguage: localization) == .rightToLeft
      let semanticContentAttribute: UISemanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
      updateSemanticContentAttribute(semanticContentAttribute)
  }
}
