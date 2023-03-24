//
//  DiscoverView.swift
//  TimeLine
//
//  Created by Alexey Primechaev on 4/3/22.
//

import SwiftUI

struct DiscoverView: View {
    
    @EnvironmentObject var context: ColorContext
    
    
    @Binding var searchText: String
    
    @State var sequences = ["One", "Two", "Three", "Four", "Five"]
    
    var titles = ["Pasta", "Pomodoro", "Homework"]
    var icons = ["🍝", "🍅", "📖", "🧹"]
    var timers: [[CGFloat]] = [[5, 10, 10, 1], [45, 5], [60, 15, 60, 10, 45]]
    
    @State var selectedSection = 0
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
               
                Text("Discover").font(.largeTitle.bold())
                VStack(alignment: .leading, spacing: 24) {
                    
                    Picker("Huh", selection: $selectedSection) {
                        Text("Featured").tag(0)
                        Text("Categories").tag(1)
                        Text("Favorites").tag(2)
                    }.pickerStyle(.segmented)
                    
                    Spacer()
                    
//                    DiscoverSection(title: "New") {
//                    ForEach(searchText == "" ? titles : titles.filter {$0.lowercased().contains(searchText.lowercased()) }, id: \.self) { title in
//                        
//                        TimelineCell(title: titles[titles.firstIndex(of: title)!], icon: icons[titles.firstIndex(of: title)!], timers: timers[titles.firstIndex(of: title)!]) {
//                        }.overlay(alignment: .bottom) {
//                            PersonBadge()
//                        }
//                        
//                        
//
//                    }
//                    }

                }
                
                Spacer()
            }
            
        }.padding(.horizontal, 24).onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.primary)], for: .normal)
            UISegmentedControl.appearance().backgroundColor = UIColor(Color.appBackground)
        }.transition(.identity)
        
        
    }
}



struct PersonBadge: View {
    
    var body: some View {
        HStack {
            Label("3 likes", systemImage: "heart.fill").font(.footnote.semibold()).padding(.horizontal, 12).padding(.vertical, 4).background(Capsule(style: .continuous).foregroundColor(.appBackground2)).overlay(Capsule(style: .continuous).strokeBorder(Color.appBackground3))
            
            Image("person").frame(width: 32, height: 32).clipShape(Circle()).overlay(Circle().strokeBorder(Color.appBackground3, lineWidth: 1))
        }.offset(y: 16)
    }
}

struct DiscoverSection<Content: View>: View {
    
    @State var title = ""
    
    var content: () -> Content
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 18) {
            
            Text(title).font(.title2).bold()
            
            VStack(alignment: .leading, spacing: 24) {
                
                content()
            }
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Label {
                        Image(systemName: "chevron.right.circle")
                    } icon: {
                        Text("Show All")
                    }.padding(12).font(.headline)
                }
                Spacer()
            }
        }
        
    }
}


extension Font {
    func semibold() -> Font {
        return self.weight(.semibold)
    }
}
