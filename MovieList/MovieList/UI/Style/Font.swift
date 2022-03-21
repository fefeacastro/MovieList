import UIKit

extension UIFont {
    static func medium(weight: Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: 14, weight: weight)
    }
    
    static func title(weight: Weight = .semibold) -> UIFont {
        UIFont.boldSystemFont(ofSize: 20)
    }
}
