//
//  HumidityView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI

struct HumidityView: View {

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
            VStack(spacing: 15) {
                
                HStack{
                    
                    Image(systemName: "humidity.fill")
                        .renderingMode(.original)
                        .foregroundColor(.blue)
                        .font(.system(size:19))
                    Text("HUMIDITY        ")
                        
                }
                
                // MARK: Forecast Date
                HStack{
                    Text(weather.main.humidity.roundDouble() + "%")
                        .font(.title.weight(.semibold))
                    
                    Spacer()
                }
                .padding(.horizontal)
              /*  VStack(spacing: -4) {
                    // MARK: Forecast Small Icon
                    Image("\(forecast.icon) small")
               
               WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
               }
                    
                    // MARK: Forecast Probability
                    
                }
                .frame(height: 42)*/
                
                // MARK: Forecast Temperature
                Text("Ongoing      Air Dampness ")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray.opacity(1))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 165, height: 175)
        }
    }
    private var attributedString: AttributedString {
        let string = AttributedString(weather.main.temp.roundDouble() + "°" + "C")
        return string
    }
}



struct HumidityView_Previews: PreviewProvider {
    static var previews: some View {
        HumidityView( weather: previewWeather)
    }
}
