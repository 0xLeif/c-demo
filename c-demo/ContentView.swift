//
//  ContentView.swift
//  c-demo
//
//  Created by Leif on 4/30/22.
//

import c
import CacheStore
import SwiftUI

struct ContentView: View {
    @ObservedObject var cacheStore: CacheStore<CacheKey> = c.resolve("CacheStore")
    
    var stringValue: String {
        cacheStore.resolve(.someValue)
    }
    
    var body: some View {
        VStack {
            Text("Current Value: \(stringValue)")
            Button("Update Value") {
                cacheStore.set(value: ":D", forKey: .someValue)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            cacheStore: CacheStore(
                initialValues: [.someValue: "Preview Cache Value"]
            )
        )
    }
}
