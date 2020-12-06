//
//  UIViewControllerExtension.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation
import UIKit

extension UIViewController {
    func presentError(with message: String) {
        let alert = UIAlertController(title: "Error occured",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
