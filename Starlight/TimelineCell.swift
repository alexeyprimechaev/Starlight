//
//  Cell.swift
//  TimeLine
//
//  Created by Alexey Primechaev on 3/28/22.
//

import SwiftUI

struct TimelineCell: View {
    
    @EnvironmentObject var context: ColorContext
    
    var title = ""
    var icon = ""
    
    var timers: [CGFloat]
    
    @State var width = CGFloat(0)
    
    @State var opacity = 0.0
    @State var opacity2 = 1.0
    
    
    @State var maxWidth: CGFloat = 77+24
    
    @State var endWidth: CGFloat = 0
    
    var deleteAction: () -> ()
    
    var body: some View {
        
        
        ZStack(alignment: .trailing) {
            
            Button {
                deleteAction()
            } label: {
                VStack {
                    Spacer()
                    Text("Delete").foregroundColor(.white).padding(12).padding(.horizontal, 12).font(.headline).lineLimit(1).fixedSize()
                    Spacer()
                }.frame(width: width).background(RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.red)).opacity(opacity).clipped()
            }.buttonStyle(.navigation).zIndex(1)
            
            
            
            
            
            
            
            HStack(spacing:12) {
                Text(icon).font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text(title).font(.headline)
                    Text("\(timers.count) timers, \(Int(timers.reduce(0, +)))m").font(.body)
                }
                Spacer()
            }.padding(12).padding(.vertical, 12).opacity(opacity2)
                .background(HStack(spacing: 0){
                    CellBackground(timers: timers)
                    Rectangle().foregroundColor(.clear).frame(width: width)
                }).zIndex(0)
            
            
            
            
        }
        .gesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { gesture in
                    withAnimation(.interactiveSpring()) {
                        width = -gesture.translation.width + endWidth
                        opacity = -gesture.translation.width/maxWidth + endWidth
                        print(gesture.translation.width+endWidth)
                        opacity2 = (1+((gesture.translation.width+maxWidth - endWidth)/maxWidth*1))
                    }
                    
                    
                }
            
                .onEnded { gesture in
                    
                    if -gesture.translation.width > maxWidth - 24 {
                        withAnimation(.spring()) {
                            width = maxWidth
                            opacity = 1
                            opacity2 = 1
                            endWidth = 77
                        }
                    } else {
                        withAnimation(.spring()) {
                            width = 0
                            opacity = 0
                            opacity2 = 1
                            endWidth = 0
                        }
                    }
                    
                    
                }
        )
        
        
    }
    
    
}


struct CellBackground: View {
    @EnvironmentObject var context: ColorContext
    
    
    var timers: [CGFloat]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(timers, id: \.self) { timer in
                    RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.appBackground2).frame(width: geometry.size.width*(timer/timers.reduce(0, +)))
                }
            }
        }
    }
}

