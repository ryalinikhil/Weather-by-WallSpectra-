//
//  AqiView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI

struct AqiView: View {
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
                    Image(systemName: "aqi.medium")
                        .renderingMode(.original)
                        .font(.system(size:20))
                        .foregroundColor(.blue)                    
                    Text("AQI INDEX   ")
                }

                VStack{
                    Gauge(value: 7, in: 0...500) {
                        Text("Loading")
                    } currentValueLabel: {
                        Image(systemName: "xmark.icloud.fill")
                            .renderingMode(.original)
                            .font(.system(size:17))
                            .foregroundColor(.red.opacity(0.9))
                    } minimumValueLabel: {
                        Text("0")
                            .font(.system(size: 10))
                    } maximumValueLabel: {
                        Text("500")
                            .font(.system(size: 10))
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(Gradient(colors: [.blue.opacity(0.7),.blue.opacity(0.4), .purple.opacity(0.4), .purple.opacity(0.7), .purple]))
                    .scaleEffect(1.4)
                    .onAppear {
                        Task {
                            for i in 0...500 {
                                loading = Double(i)
                                try await Task.sleep(for: .milliseconds(20))
                            }
                        }
                    }
                    Text("   ")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray.opacity(1))
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 7)
            .frame(width: 165, height: 165)
        }
    }
}


struct AqiView_Previews: PreviewProvider {
    static var previews: some View {
        AqiView(weather: previewWeather)
    }
}
