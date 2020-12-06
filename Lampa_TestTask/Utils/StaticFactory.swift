//
//  StaticFactory.swift
//  Lampa_TestTask
//
//  Created by Serhii Bychin on 06.12.2020.
//

import Foundation

protocol StaticFactory {
    associatedtype Factory
}

extension StaticFactory {
    static var factory: Factory.Type { return Factory.self }
}
