//
//  DetailedView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI

struct DetailedView: View {
    var body: some View {
        VStack(spacing: 15) {
            
            HStack(spacing: 15){
                MinTemView(weather: previewWeather)
                MaxTemView(weather: previewWeather)
            }
            .padding(.horizontal)
            
            HStack(spacing: 15){
              //  WindSpeedView(weather: previewWeather)
                ForecastCardB( weather: previewWeather)
            }
            .padding(.horizontal)
            
        //    NewView(weather: previewWeather)
            
            
            HStack(spacing: 15){
                HumidityView( weather: previewWeather)
                AqiView(weather: previewWeather)
            }
            .padding(.horizontal)
                        
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
       // .frame(width: 165, height: 165)
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView()
    }
}
