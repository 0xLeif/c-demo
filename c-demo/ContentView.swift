//
//  ContentView.swift
//  c-demo
//
//  Created by Leif on 4/30/22.
//

import c
import CacheStore
import SwiftUI

enum ContentViewKey {
    case value
    case emoji
    case randomBool
}

struct ContentView: View {
    @ObservedObject var cacheStore: CacheStore<ContentViewKey> = c.resolve("ContentCacheStore")
    
    var stringValue: String {
        cacheStore.resolve(.emoji)
    }
    
    var body: some View {
        VStack {
            Text("Current Emoji: \(stringValue)")
            
            TextField("Emoji", text: cacheStore.binding(.emoji))
            
            if cacheStore.contains(.randomBool) {
                Toggle("bool", isOn: cacheStore.binding(.randomBool))
            }
            
            Button("Update Value") {
                cacheStore.set(value: ":D", forKey: .value)
            }
            
            if let value: String = cacheStore.get(.value) {
                Text("Value: \(value)")
            }
        }
        .background(Color.gray)
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            cacheStore: CacheStore(
                initialValues: [:]
            )
        )
    }
}
