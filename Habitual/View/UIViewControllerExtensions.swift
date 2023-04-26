//
//  UIViewControllerExtensions.swift
//  Habitual
//
//  Created by Cherish Spikes on 3/20/23.
//
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
