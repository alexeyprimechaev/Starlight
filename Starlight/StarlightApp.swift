//
//  StarlightApp.swift
//  Starlight
//
//  Created by Alexey Primechaev on 3/27/22.
//

import SwiftUI

@main
struct StarlightApp: App {
    
    @StateObject var context = ColorContext.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(context)
        }
    }
}
