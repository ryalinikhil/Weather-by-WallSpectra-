//
//  WatchView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 30/08/23.
//

import SwiftUI


/*
struct WatchView: View {    var weather: ResponseBody
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 165, height: 165)
                .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            
            Image("watch")
            
            Image(systemName: "xmark.icloud")
                .renderingMode(.original)
                .font(.system(size:29))
                .foregroundColor(.red.opacity(0.7))
            
            // MARK: Content
            VStack(spacing: 15) {
                
                HStack{
                    Image(systemName: "exclamationmark.applewatch")
                        .renderingMode(.original)
                        .font(.system(size:19))
                    
                    Spacer()
                        
                }
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 165, height: 165)
        }
    }
}



struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView( weather: previewWeather)
    }
}
 */
import SwiftUI


struct DateView: View {

    var weather: ResponseBody
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 165, height: 165)
                .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            // MARK: Content
            VStack(spacing: 10) {
                
                
                // MARK: Forecast Date
                ZStack{
                    Image("dial")
                        .scaleEffect(1.35)
                    
                    
                    Text("  "+weather.wind.deg.roundDouble()+"°")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.red.opacity(0.9))
                        
                    
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .frame(width: 165, height: 165)
        }
    }

}

struct Dates_View: PreviewProvider {
    static var previews: some View {
        DateView( weather: previewWeather)
        
    }
}


