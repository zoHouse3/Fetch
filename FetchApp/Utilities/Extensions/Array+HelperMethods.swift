//
//  Array+HelperMethods.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/10/24.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
