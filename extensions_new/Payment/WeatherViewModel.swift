//
//  WeatherViewModel.swift
//  MagicWallpaper
//
//  Created by Sameer Nikhil on 11/10/23.
//


import Foundation

/* Static shared model for WeatherView */
class WeatherViewModel: NSObject, ObservableObject {
    static let shared = WeatherViewModel()
    
    @Published var currentData: SampleWeatherData = .testCold
    @Published var currentEnvironment: SampleWeatherData.Environment = .earth
}

