//
//  Extensions.swift
//  eCommerceApp
//
//  Created by Yade KANBİR on 16.03.2023.
//

import Foundation
import UIKit

extension String {
    var isNotEmpty : Bool {
        return !isEmpty
    }
}

extension UIViewController {
    func showToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 17)
        
        let textSize = toastLabel.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        toastLabel.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth, height: textSize.height)
        toastLabel.center.x = window.center.x
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.masksToBounds = true
        
        window.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0
        }) {
            (_) in toastLabel.removeFromSuperview()
        }
    }
}
