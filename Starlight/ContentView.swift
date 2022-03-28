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
    
    @State var sequences = ["One", "Two", "Three", "Four", "Five"]
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                switch selectedTab {
                case 0:
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Library").font(.largeTitle.bold()).padding(.top, 44)
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Sequences:")
                                ForEach(searchText == "" ? sequences : sequences.filter {$0.lowercased().contains(searchText)}, id: \.self) { sequence in
                                    Text(sequence)
                                }
                            }.padding(.top, 24)
                            
                            Spacer()
                        }.padding(24)
                        
                    }.transition(.identity)
                case 1:
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Discover").font(.largeTitle.bold()).padding(.top, 44)
                            Spacer()
                        }.padding(24)
                        
                    }.transition(.identity)
                case 2:
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Profile").font(.largeTitle.bold()).padding(.top, 44)
                            Toggle("Starlight", isOn: $context.isStarlight).toggleStyle(.switch).tint(.accentColor)

                            Spacer()
                        }.padding(24)
                        
                    }.transition(.identity)
                    
                    
                default:
                    Text("eror")
                }
                
                
                UnifiedTabBar(selectedTab: $selectedTab, searchText: $searchText) {
                    sequences.append("New Sequence")
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
