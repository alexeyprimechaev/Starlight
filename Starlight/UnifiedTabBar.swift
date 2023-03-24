//
//  UnifiedTabBar.swift
//  Starlight
//
//  Created by Alexey Primechaev on 3/27/22.
//

import SwiftUI

enum Placement {
    case leading, trailing
}


struct Action: Identifiable {
    
    var id = UUID()
    var title: String
    var icon: String
    
    var action: () -> ()
    
}

struct UnifiedTabBar: View {
    
    
    
    
    
    @Binding var selectedTab: Int
    @Binding var searchText: String
    
    @State var isSearching = false
    
    var primaryAction: () -> ()
    
    var actions1 = [Action(title: "Add New", icon: "plus", action: {})]
    var actions2 = [Action(title: "Favorites", icon: "heart", action: {})]
    
    var body: some View {
        
        HStack(spacing: 0) {
            UnifiedTabItem(selectedTab: $selectedTab, isSearching: $isSearching, searchText: $searchText, tag: 0, title: "Library", icon: "tray.fill", actions: actions1)
            UnifiedTabItem(selectedTab: $selectedTab, isSearching: $isSearching, searchText: $searchText, tag: 1, title: "Discover", icon: "square.grid.3x3.square", actionPlacement: .trailing, actions: actions2)
        }.padding(.horizontal, 18)
    }
}


struct UnifiedTabItem: View {
    @EnvironmentObject var context: ColorContext
    
    @Namespace private var animation
    
    @Binding var selectedTab: Int
    
    @Binding var isSearching: Bool
    @Binding var searchText: String
    
    @FocusState private var isFocused: Bool
    
    @ScaledMetric(relativeTo: .headline) private var height = 22
    
    var tag: Int
    var title: String
    var icon: String
    
    var actionPlacement: Placement
    
    var actions: [Action]
    
    init(selectedTab: Binding<Int>, isSearching: Binding<Bool>, searchText: Binding<String>, tag: Int, title: String, icon: String, actionPlacement: Placement = .leading, actions: [Action] = []) {
        
        self._selectedTab = selectedTab
        self._searchText = searchText
        self._isSearching = isSearching
        
        self.tag = tag
        self.title = title
        self.icon = icon
        
        self.actionPlacement = actionPlacement
        self.actions = actions
        
    }
    
    var body: some View {
        
        
        HStack(spacing:0) {
            if !isSearching && tag == selectedTab {
                if actionPlacement == .leading {
                    ForEach(actions) { action in
                        HStack(spacing: 0) {
                            Button {
                                action.action()
                                
                            } label: {
                                Label(action.title, systemImage: action.icon).labelStyle(.iconOnly).imageScale(.large)
                            }.padding(.vertical, 6).padding(.horizontal, 6).buttonStyle(.borderless)
                            
                        }
                    }.padding(.trailing, 6).zIndex(Double((tag*10)+0))
                }
            }
            if !(isSearching && tag != selectedTab) {
                
                
                Button {
                    if isSearching {
                        
                    } else {
                        if selectedTab == tag {
                            withAnimation {
                                isSearching = true
                                isFocused = true
                            }
                        } else {
                            withAnimation {
                                selectedTab = tag
                            }
                        }
                    }
                } label: {
                    ZStack {
                        HStack(spacing: 0) {
                            if selectedTab == tag {
                                Spacer()
                            }
                            HStack(spacing: 0) {
                                Image(systemName: isSearching && tag == selectedTab ? "magnifyingglass" : icon).foregroundColor(isSearching && tag == selectedTab ? Color(UIColor.placeholderText) : .primary).frame(width: height, height: height, alignment: .center)
                                
                                
                                if selectedTab == tag {
                                    Spacer().frame(width: 8)
                                    Text(isSearching ? "Search \(title)" : title)
                                        .opacity(searchText.count == 0 ? 1 : 0)
                                        .lineLimit(1)
                                    
                                        .matchedGeometryEffect(id: tag, in: animation, properties: .position)
                                    //.transition(.opacity.combined(with: .move(edge: tag == 0 ? .leading : .trailing)))
                                } else {
                                    Text("").frame(width: 0).matchedGeometryEffect(id: tag, in: animation, properties: .position)
                                }
                                
                                if isSearching {
                                    Spacer()
                                }
                                
                                
                                
                                
                            }.disabled(isSearching ? true : false)
                            
                            
                            if selectedTab == tag {
                                Spacer()
                            }
                        }.foregroundColor(isSearching && tag == selectedTab ? Color(UIColor.placeholderText) : .primary).opacity(tag == selectedTab ? 1 : 0.667)
                        if selectedTab == tag {
                            HStack(spacing: 0) {
                                if selectedTab == tag {
                                    Spacer()
                                }
                                Label {
                                    TextField("", text: $searchText).focused($isFocused).opacity(isSearching ? 1 : 0)
                                    if searchText.count > 0 {
                                        Button {
                                            searchText = ""
                                        } label: {
                                            Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                                        }.animation(.default, value: searchText.count > 0).transition(.opacity)
                                    }
                                } icon: {
                                    
                                    Image(systemName: isSearching && tag == selectedTab ? "magnifyingglass" : icon).foregroundColor(isSearching && tag == selectedTab ? Color(UIColor.placeholderText) : .primary).frame(width: height, height: height, alignment: .center).opacity(0)
                                }
                                if selectedTab == tag {
                                    Spacer()
                                }
                            }.disabled(isSearching ? false : true)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(selectedTab == tag ? .primary : .secondary)
                    .imageScale(.medium)
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous)).clipped()
                    .padding(.horizontal, 6)
                    .padding(.vertical, 12)
                }
                
                .buttonStyle(.navigation)
                .foregroundColor(selectedTab == tag ? .appBackground3 : .appBackground2)
                .zIndex(Double((tag*10)+2))
            }
            if isSearching && tag == selectedTab {
                Button {
                    isFocused = false
                    searchText = ""
                    withAnimation {
                        isSearching = false
                    }
                    
                    
                } label: {
                    Text("Cancel")
                        .font(.body)
                        .padding(.horizontal, 6)
                        .padding(6)
                    
                }.animation(.default, value: isSearching).transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
            if !isSearching && tag == selectedTab {
                if actionPlacement == .trailing {
                    ForEach(actions) { action in
                        HStack(spacing: 0) {
                            Button {
                                action.action()
                                
                            } label: {
                                Label(action.title, systemImage: action.icon).labelStyle(.iconOnly).imageScale(.large)
                            }.padding(.vertical, 6).padding(.horizontal, 6).buttonStyle(.borderless)
                            
                        }
                    }.padding(.leading, 6).zIndex(Double((tag*10)+1))
                }
            }
        }
        
        
    }
    
}

struct NavigationButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}




extension ButtonStyle where Self == NavigationButtonStyle {
    
    internal static var navigation: NavigationButtonStyle {
        NavigationButtonStyle()
    }
}
