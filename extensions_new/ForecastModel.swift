//
//  ForecastModel.swift
//  Weather
//
//  Created by Dara To on 2022-06-19.
//

import Foundation


 enum ForecastPeriod {
     case hourly
     case daily
 }

 enum Weather: String {
     case clear = "Clear"
     case cloudy = "Cloudy"
     case rainy = "Mid Rain"
     case stormy = "Showers"
     case sunny = "Sunny"
     case tornado = "Tornado"
     case windy = "Fast Wind"
 }

 struct Forecast: Identifiable {
     var id = UUID()
     var date: Date
     var weather: Weather
     var probability: Int
     var temperature: Int
     var high: Int
     var low: Int
     var location: String
     
     var icon: String {
         switch weather {
         case .clear:
             return "Moon"
         case .cloudy:
             return "Cloud"
         case .rainy:
             return "Moon cloud mid rain"
         case .stormy:
             return "Sun cloud angled rain"
         case .sunny:
             return "Sun"
         case .tornado:
             return "Tornado"
         case .windy:
             return "Moon cloud fast wind"
         }
     }
 }

 extension Forecast {
     static let hour: TimeInterval = 60 * 60
     static let day: TimeInterval = 60 * 60 * 24
     
     static let hourly: [Forecast] = [
        // Forecast(date: .init(timeIntervalSinceNow: hour * -1), weather: .rainy, probability: 30, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
         Forecast(date: .now, weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        // Forecast(date: .init(timeIntervalSinceNow: hour * 1), weather: .windy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
       //  Forecast(date: .init(timeIntervalSinceNow: hour * 2), weather: .rainy, probability: 0, temperature: 18, high: 24, low: 18, location: "Montreal, Canada"),
      //   Forecast(date: .init(timeIntervalSinceNow: hour * 3), weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
       //  Forecast(date: .init(timeIntervalSinceNow: hour * 4), weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada")
     ]
     
     static let daily: [Forecast] = [
         Forecast(date: .init(timeIntervalSinceNow: 0), weather: .rainy, probability: 30, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
       //  Forecast(date: .init(timeIntervalSinceNow: day * 1), weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
       //  Forecast(date: .init(timeIntervalSinceNow: day * 2), weather: .stormy, probability: 100, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
       //  Forecast(date: .init(timeIntervalSinceNow: day * 3), weather: .stormy, probability: 50, temperature: 18, high: 24, low: 18, location: "Montreal, Canada"),
      //   Forecast(date: .init(timeIntervalSinceNow: day * 4), weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
       //  Forecast(date: .init(timeIntervalSinceNow: day * 5), weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada")
     ]
     
     static let cities: [Forecast] = [
         Forecast(date: .now, weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
         Forecast(date: .now, weather: .windy, probability: 0, temperature: 20, high: 21, low: 19, location: "Toronto, Canada"),
         Forecast(date: .now, weather: .stormy, probability: 0, temperature: 13, high: 16, low: 8, location: "Tokyo, Japan"),
         Forecast(date: .now, weather: .tornado, probability: 0, temperature: 23, high: 26, low: 16, location: "Tennessee, United States")
     ]
 }


 
 
 /*
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}


extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
*/
