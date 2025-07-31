//
//  MyAtlasApp.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//

import SwiftUI
import SDWebImageSVGCoder
import SDWebImage

@main
struct MyAtlasApp: App {
    
    init() {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
