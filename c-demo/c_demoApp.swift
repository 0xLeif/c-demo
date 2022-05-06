//
//  c_demoApp.swift
//  c-demo
//
//  Created by Leif on 4/30/22.
//

import c
import CacheStore
import SwiftUI

enum CacheKey: Hashable {
    case valueToChange
    case someValue
    case someOtherValue
}

@main
struct DemoApp: App {
    @StateObject var cacheStore = CacheStore<CacheKey>(
        initialValues: [
            .someValue: "🥳",
            .someOtherValue: { fatalError() }
        ]
    )
    
    var body: some Scene {
        c.set(value: cacheStore, forKey: "CacheStore")
        
        let contentCacheStore: CacheStore<ContentViewKey> = cacheStore.scope(
            keyTransformation: c.transformer(
                from: { cacheKey in
                    switch cacheKey {
                    case .valueToChange: return .value
                    case .someValue: return .emoji
                    default: return nil
                    }
                },
                to: { contentViewKey in
                    switch contentViewKey {
                    case .value: return .valueToChange
                    case .emoji: return .someValue
                    default: return nil
                    }
                }
            )
        )
        c.set(value: contentCacheStore, forKey: "ContentCacheStore")
        
        return WindowGroup {
            VStack {
                if let value: String = cacheStore.get(.valueToChange) {
                    Text(value)
                        .font(.largeTitle)
                    
                    Button("Remove") {
                        cacheStore.set(value: NSNull(), forKey: .valueToChange)
                    }
                }
                Text("@StateObject value: \(cacheStore.resolve(.someValue) as String)")
                ContentView()
            }
        }
    }
}
