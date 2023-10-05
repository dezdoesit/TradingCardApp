//
//  ContentView.swift
//  ADAHiFi
//
//  Created by dmoney on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{
            let size = $0.size
            Home(size: size)
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
        
}
