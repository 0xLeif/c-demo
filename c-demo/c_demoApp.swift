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
    case someValue
}

@main
struct DemoApp: App {
    @StateObject var cacheStore = CacheStore<CacheKey>(
        initialValues: [.someValue: "🥳"]
    )
    
    var body: some Scene {
        c.set(value: cacheStore, forKey: "CacheStore")
        
        return WindowGroup {
            VStack {
                Text("@StateObject value: \(cacheStore.resolve(.someValue) as String)")
                ContentView()
            }
        }
    }
}
