//
//  AppCoordinator.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation
import UIKit

final class AppCoordinator {
    static let shared = AppCoordinator()
    
    func startInterface(in window: UIWindow) {

        let moviesVC = MoviesViewController.Factory.default
        let navigationVC = UINavigationController(rootViewController: moviesVC)
        
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }
}
