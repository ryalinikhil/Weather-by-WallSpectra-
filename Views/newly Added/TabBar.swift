//
//  TabBar.swift
//  Weather
//
//  Created by Dara To on 2022-06-13.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            // MARK: Arc Shape
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay {
                    // MARK: Arc Border
                    Arc()
                        .stroke(Color.tabBarBorder, lineWidth: 0.5)
                }
            
            // MARK: Tab Items
            HStack {
                // MARK: Expand Button
                Button {
                    action()
                } label: {
                    Image(systemName: "location.north.circle.fill")
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 45, height: 45)
                }
                
                Spacer()
                
                // MARK: Navigation Button
                NavigationLink {
                    NewView(weather: previewWeather)
                } label: {
                    Image(systemName: "globe.central.south.asia.fill")
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 45, height: 45)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(action: {})
            .preferredColorScheme(.dark)
    }
}
