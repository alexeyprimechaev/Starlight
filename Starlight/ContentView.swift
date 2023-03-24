//
//  ContentView.swift
//  Starlight
//
//  Created by Alexey Primechaev on 3/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var context: ColorContext
    
    @State var selectedTab = 0
    
    @State var searchText = ""
    
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Spacer()
                    Menu {
//                            Button {
//
//                            } label: {
//                                Label("Select", systemImage: "checkmark.circle")
//                            }
                        Divider()
                        Picker("Theme", selection: $context.isStarlight) {
                            Label("Silver", systemImage: "circle").tag(false)
                            Label("Starlight", systemImage: "sparkles").tag(true)
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle").imageScale(.large).padding(.horizontal, 24).padding(.vertical, 9)
                    }
                }
                switch selectedTab {
                case 0:
                    
                    LibraryView(searchText: $searchText)
                case 1:
                    DiscoverView(searchText: $searchText)

                    
                    
                default:
                    Text("eror")
                }
                
                
                UnifiedTabBar(selectedTab: $selectedTab, searchText: $searchText) {
                    
                }
                
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
    static var appBackground3: Color {
        if context.isStarlight {
            return Color("starlightP33")
        } else {
            return Color(UIColor.systemGray5)
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
