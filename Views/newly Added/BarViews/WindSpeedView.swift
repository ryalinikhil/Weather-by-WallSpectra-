//
//  WindSpeedView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//
/*
import SwiftUI

struct WindSpeedView: View {
    var weather: ResponseBody
    @State var loading = 50.0
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
            VStack(spacing: 23) {
                
                HStack{
                    Image(systemName: "wind.circle.fill")
                        .renderingMode(.original)
                        .font(.system(size:19))
                        .foregroundColor(.blue)
                    
                    Text("WIND SPEED       ")
                        
                }
                
                VStack{
                    Gauge(value: weather.wind.speed, in: 0...25) {
                        Text("Loading")
                    } currentValueLabel: {
                        Text("\(weather.wind.speed.roundDouble())")
                    } minimumValueLabel: {
                        Text("0")
                            .font(.system(size: 10))
                    } maximumValueLabel: {
                        Text("25")
                            .font(.system(size: 10))
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(Gradient(colors: [.blue.opacity(0.7),.blue.opacity(0.4), .purple.opacity(0.4), .purple.opacity(0.7), .purple]))
                    .scaleEffect(1.3)
                    
                    Text("  m/s ")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray.opacity(1))
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 7)
            .frame(width: 165, height: 175)
            
        }
    }
   
}



struct WindSpeedView_Previews: PreviewProvider {
    static var previews: some View {
        WindSpeedView(weather: previewWeather)
    }
}
*/

import SwiftUI

struct TempView: View {
    var weather: ResponseBody
    @State var loading = 50.0
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
            VStack(spacing: 35) {
                
                HStack{
                    Image(systemName: "thermometer.transmission")
                        .renderingMode(.original)
                        .font(.system(size:19))
                        .foregroundColor(.teal)
                    
                    Text("TEMP           ")
                        
                }
                
                VStack{
                    Gauge(value: weather.main.temp, in: -30...50) {
                        Text("Loading")
                    } currentValueLabel: {
                        Text(weather.main.temp.roundDouble() + "°C")
                    } minimumValueLabel: {
                        Text("-30")
                            .font(.system(size: 10))
                    } maximumValueLabel: {
                        Text("50")
                            .font(.system(size: 10))
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(Gradient(colors: [.red.opacity(0.7),.red.opacity(0.4), .green.opacity(0.4), .green.opacity(0.7),.green]))
                    .scaleEffect(1.6)
                    
                    Text("")
                    
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 7)
            .frame(width: 165, height: 175)
            
        }
    }
   
}



struct WindSpeedView_Previews: PreviewProvider {
    static var previews: some View {
        TempView(weather: previewWeather)
    }
}

