//
//  BottonForecastCards.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI


struct ForecastCardB: View {
 //   var forecast: Forecast
   // var forecastPeriod: ForecastPeriod
   // var weather: ResponseBody

  /*  var isActive: Bool {
        if forecastPeriod == ForecastPeriod.hourly {
            let isThisHour = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .hour)
            return isThisHour
        } else {
            let isToday = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .day)
            return isToday
        }
    }*/
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
                    Image(systemName: "thermometer.sun.fill")
                        .renderingMode(.original)
                        .font(.system(size:19))
                    
                    Text("FEELS LIKE    ")
                        
                }
                
                // MARK: Forecast Date
                Text(weather.main.feelsLike.roundDouble() + "°C")
                    .font(.title.weight(.semibold))
                
              /*  VStack(spacing: -4) {
                    // MARK: Forecast Small Icon
                    Image("\(forecast.icon) small")
                    
                    // MARK: Forecast Probability
                    
                }
                .frame(height: 42)*/
                
                // MARK: Forecast Temperature
                Text("Similar to actual Temparature")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color.gray.opacity(1))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 165, height: 175)
        }
    }
    private var attributedString: AttributedString {
        let string = AttributedString(weather.main.temp.roundDouble() + "°" + "C")
        return string
    }
}

struct ForecastCard_Previews_Bottom: PreviewProvider {
    static var previews: some View {
        ForecastCardB( weather: previewWeather)
        
    }
}
