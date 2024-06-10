//
//  URLCache+ImageCache.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/10/24.
//

import Foundation

extension URLCache {
    static let ImageCache = URLCache(memoryCapacity: (1024 * 1024) * 65, // roughly 65 MB
                                     diskCapacity: 1 * 1024 * 1024 * 1024) // 1 GB
}
