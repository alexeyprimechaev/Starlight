//
//  UnifiedTabBar.swift
//  Starlight
//
//  Created by Alexey Primechaev on 3/27/22.
//

import SwiftUI

struct UnifiedTabBar: View {
    
    
    
    
    
    @State var selectedTab = 0
    
    @State var isSearching = false

    
    var tabs = ["My Sequences", "Discover"]
    
    var body: some View {
        
        HStack(spacing: isSearching ? 0 : 12) {
            
            
            if !isSearching {
            if selectedTab == 0 {
                Button {

                } label: {
                    Image(systemName: "plus").imageScale(.large)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                       
                }
                
                
            }
            }
            
            UnifiedTabItem(selectedTab: $selectedTab, isSearching: $isSearching, tag: 0, title: "Library", icon: "tray.fill")
                
            UnifiedTabItem(selectedTab: $selectedTab, isSearching: $isSearching, tag: 1, title: "Discover", icon: "square.grid.3x3.square")
            UnifiedTabItem(selectedTab: $selectedTab, isSearching: $isSearching, tag: 2, title: "Profile", icon: "person.fill")
            
            

            
        }.padding(12).padding(.trailing, !isSearching ? 12 : 0).padding(.leading, isSearching || selectedTab > 0 ? 12 : 0)
    }
}


struct UnifiedTabItem: View {
    @EnvironmentObject var context: ColorContext
    
    @Namespace private var animation
    
    @Binding var selectedTab: Int
    
    @Binding var isSearching: Bool
    @State var searchText = ""

    @FocusState var isFocused: Bool

    var tag: Int
    
    var title: String
    
    var icon: String
    
    var body: some View {
        
        
        HStack(spacing:12) {
        if !(isSearching && tag != selectedTab) {
            
        
        Button {
            if selectedTab == tag {
                withAnimation {
                isSearching = true
                isFocused = true
                }
            } else {
                withAnimation(.default) {
                    selectedTab = tag
                }
            }
        } label: {
            HStack(spacing: 0) {
            if selectedTab == tag {
                Spacer()
            }
            Label {
                if selectedTab == tag {
                    ZStack {
                        Text(title)
                            .id(tag)
                            .lineLimit(1)
                            .transition(.opacity.combined(with: .move(edge: tag == 0 ? .leading : .trailing)))
                        
                        TextField("Search \(title)", text: $searchText).focused($isFocused).opacity(isSearching ? 1 : 0)
                        if searchText.count > 0 {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                            }.animation(.default, value: searchText.count > 0).transition(.opacity)
                        }
                        
                    }

                        
                    
                    
                }
            } icon: {
                Image(systemName: isSearching && tag == selectedTab ? "magnifyingglass" : icon).foregroundColor(isSearching && tag == selectedTab ? Color(UIColor.placeholderText) : .primary).id(tag)

            }
                .font(.headline)
                .foregroundColor(.primary)
                .imageScale(.medium)
                .padding(12)
                
            if selectedTab == tag {
                Spacer()
            }
            }.background(RoundedRectangle(cornerRadius: 12, style: .continuous)).clipped()
        }.tint(.appBackground2).opacity(selectedTab == tag ? 1 : 0.5)
        }
            if isSearching && tag == selectedTab {
                Button {
                    isFocused = false
                    searchText = ""
                    withAnimation {
                        isSearching = false
                    }
                    
                    
                } label: {
                    Text("Done").imageScale(.large)
                        .font(.headline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                }.transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .identity))
            }

        }
            
        
    }
}

struct UnifiedTabBar_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedTabBar()
    }
}

