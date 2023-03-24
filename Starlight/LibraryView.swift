//
//  LibraryView.swift
//  TimeLine
//
//  Created by Alexey Primechaev on 4/3/22.
//

import SwiftUI

struct LibraryView: View {
    
    @Binding var searchText: String
    
    @State var sequences = ["One", "Two", "Three", "Four", "Five"]
    
    var titles = ["Pasta", "Pomodoro", "Homework", "Cleanup"]
    var icons = ["🍝", "🍅", "📖", "🧹"]
    var timers: [[CGFloat]] = [[5, 10, 10, 1], [45, 5], [60, 15, 60, 10, 45], [5, 5, 10, 60, 40, 5]]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
               
                Text("Library").font(.largeTitle.bold()).padding(.leading, 24)
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(searchText == "" ? titles : titles.filter {$0.lowercased().contains(searchText.lowercased()) }, id: \.self) { title in
                        
                        TimelineCell(title: titles[titles.firstIndex(of: title)!], icon: icons[titles.firstIndex(of: title)!], timers: timers[titles.firstIndex(of: title)!]) {
                        }

                    }

                }.padding(24)
                
                Spacer()
            }
            
        }.transition(.identity)
    }
}


