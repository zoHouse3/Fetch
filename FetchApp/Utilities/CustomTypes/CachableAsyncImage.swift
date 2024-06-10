//
//  CachableAsyncImage.swift
//  FetchApp
//
//  Created by Eric Barnes - iOS on 6/10/24.
//
/*
  - Cache dessert detail images, so that we do not have to re-fetch
 */
import SwiftUI

struct CachableAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View{
        if let cached = ImageCache[url] {
            let _ = print("cached: \(url.absoluteString)") // confirm caching is working
            content(.success(cached))
        } else {
            // otherwise perform download using AsyncImage
            let _ = print("request: \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success (let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}
// simple caching implementation ... would not be used in production
fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image?{
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
