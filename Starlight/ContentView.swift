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
    
    var titles = ["Pasta", "Pomodoro", "Homework", "Cleanup"]
    var icons = ["🍝", "🍅", "📖", "🧹"]
    var timers: [[CGFloat]] = [[5, 10, 10, 1], [45, 5], [60, 15, 60, 10, 45], [5, 5, 10, 60, 40, 5]]
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                switch selectedTab {
                case 0:
                    HStack {
                        Spacer()
                        Menu {
                            Picker("Theme", selection: $context.isStarlight) {
                                Label("Starlight", systemImage: "moon.stars").tag(true)
                                Label("Silver", systemImage: "circle").tag(false)
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle").imageScale(.large).padding(.horizontal, 24).padding(.vertical, 9)
                        }
                    }
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                           
                            Text("Library").font(.largeTitle.bold()).padding(.leading, 24)
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(searchText == "" ? titles : titles.filter {$0.lowercased().contains(searchText.lowercased()) }, id: \.self) { title in
                                    
                                    TimelineCell(title: titles[titles.firstIndex(of: title)!], icon: icons[titles.firstIndex(of: title)!], timers: timers[titles.firstIndex(of: title)!])

                                }
    
                            }.padding(24)
                            
                            Spacer()
                        }
                        
                    }.transition(.identity)
                case 1:
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                Image(systemName: "ellipsis.circle").imageScale(.large).padding(.horizontal, 24).padding(.vertical, 9)
                            }
                            Text("Discover").font(.largeTitle.bold()).padding(.leading, 24)

                            
                            Spacer()
                        }
                        
                    }.transition(.identity)
                case 2:
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                Image(systemName: "ellipsis.circle").imageScale(.large).padding(.horizontal, 24).padding(.vertical, 9)
                            }
                            Text("Profile").font(.largeTitle.bold()).padding(.leading, 24)
                            VStack(alignment: .leading, spacing: 12) {
                                Toggle("Starlight", isOn: $context.isStarlight).toggleStyle(.switch).tint(.accentColor)
    
                            }.padding(24)
                            
                            Spacer()
                        }
                       
                        
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
