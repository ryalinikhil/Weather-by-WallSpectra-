//
//  MaxTemView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI

struct MaxTemView: View {

    var weather: ResponseBody = previewWeather
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
            VStack(spacing: 15) {
                
                HStack{
                    
                    Image(systemName: "thermometer.high")
                        .renderingMode(.original)
                        .font(.system(size:19))
                    Text("MAX TEMP     ")
                        
                }
                
                // MARK: Forecast 
                HStack{
                  //  Text(weather.coord.lon.roundDouble() + "°C")
                  //  Text("\(String(format: "%.2f", weather.coord.lon))")
                    Text("\(weather.coord.lat.description)")
                        .font(.title.weight(.semibold))
                        //.font(.title.weight(.semibold))
                    Spacer()
                }
                .padding(.horizontal)
                
                // MARK: Forecast Max Temperature
                Text("Peak Temparature ")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray.opacity(1))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 195, height: 195)
        }
    }
    private var attributedString: AttributedString {
        let string = AttributedString(weather.main.temp.roundDouble() + "°" + "C")
        return string
    }
}



struct MaxTemView_Previews: PreviewProvider {
    static var previews: some View {
        MaxTemView(weather: previewWeather)
    }
}
