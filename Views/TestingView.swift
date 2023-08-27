//
//  TestingView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 16/10/23.
//

import SwiftUI




import SwiftUI

struct TestingView: View {
    var forecast: Forecast
    var forecastPeriod: ForecastPeriod
    var weather: ResponseBody

    var isActive: Bool {
        if forecastPeriod == ForecastPeriod.hourly {
            let isThisHour = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .hour)
            return isThisHour
        } else {
            let isToday = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .day)
            return isToday
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 70, height: 150)
                .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            // MARK: Content
            VStack(spacing: 16) {
                // MARK: Forecast Date
                VStack(spacing: 15){
                    Spacer(minLength: 40)
                    Text(forecast.date, format: forecastPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(Color.white)
                    Text("|")
                        .foregroundColor(Color.white.opacity(0.4))
                        .font(.subheadline.weight(.semibold))
                    Text((Calendar.current.date(byAdding: .hour, value: 1, to: forecast.date) ?? forecast.date), format: forecastPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(Color.white)
                }
                
                VStack(spacing: -4) {
                    // MARK: Forecast Small Icon
                    Image("\(forecast.icon) small")
                    
                    // MARK: Forecast Probability
                    
                }
                .frame(height: 42)
                
                // MARK: Forecast Temperature
               // Text(attributedString)
                  //  .font(.title3)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 70, height: 150)
        }
    }
    private var attributedString: AttributedString {
        let string = AttributedString(weather.main.temp.roundDouble() + "°" + "C")
        return string
    }
}

struct ForecastCard_Previews1: PreviewProvider {
    static var previews: some View {
        TestingView(forecast: Forecast.hourly[0], forecastPeriod: .hourly , weather: previewWeather)
        
    }
}
