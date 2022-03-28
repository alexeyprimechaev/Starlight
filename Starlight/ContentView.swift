//
//  ContentView.swift
//  Starlight
//
//  Created by Alexey Primechaev on 3/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var context: ColorContext
    
        
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
            Toggle("", isOn: $context.isStarlight).padding().background(Color.appBackground2).padding(24)
                Spacer()
                UnifiedTabBar()
                
            }
            

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    
    static let context = ColorContext.shared
    static var appBackground: Color {
        if context.isStarlight {
            return Color("starlightP3")
        } else {
            return Color(UIColor.systemBackground)
        }
    }
    static var appBackground2: Color {
        if context.isStarlight {
            return Color("starlightP32")
        } else {
            return Color(UIColor.secondarySystemBackground)
        }
    }
}



class ColorContext: ObservableObject {
    
    static let shared = ColorContext()
    
    @AppStorage("isStarlight") var isStarlight = false
}


public protocol EnvironmentKey {
  associatedtype Value
  static var defaultValue: Self.Value { get }
}


//HStack {
//    Button {
//        
//    } label: {
//        Image(systemName: "plus").imageScale(.large)
//        
//    }
//    Spacer()
//    Button {
//        
//    } label: {
//        Label("Start Sequence", systemImage: "play.fill")
//            .font(.headline)
//            .foregroundColor(.appBackground)
//            .imageScale(.medium)
//            .padding(.vertical, 12)
//            .padding(.horizontal, 24)
//            .background(RoundedRectangle(cornerRadius: 12, style: .continuous))
//        
//    }
//    
//    .buttonStyle(.plain)
//    
//}
//.padding(24)
