//
//  GaugeSpeed.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI
/*
struct GaugeSpeed: View {
    @State var loading = 50.0

    var body: some View {
        VStack {
            Gauge(value: loading, in: 50...200) {
                Text("Loading")
            } currentValueLabel: {
                Text("\(loading)")
            } minimumValueLabel: {
                Text("50")
                    .font(.system(size: 10))
            } maximumValueLabel: {
                Text("200")
                    .font(.system(size: 10))
            }
            .gaugeStyle(.accessoryCircular)
            .tint(Gradient(colors: [.green, .yellow, .orange, .red]))

            Gauge(value: loading, in: 50...200) {
                Text("Loading")
            } currentValueLabel: {
                Text("\(loading)")
            } minimumValueLabel: {
                Text("50")
                    .font(.system(size: 10))
            } maximumValueLabel: {
                Text("200")
                    .font(.system(size: 10))
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.green)

            Gauge(value: loading, in: 50...200) {
                Text("Loading")
            } currentValueLabel: {
                Text("\(loading)")
            } minimumValueLabel: {
                Text("50")
                    .font(.system(size: 10))
            } maximumValueLabel: {
                Text("200")
                    .font(.system(size: 10))
            }
            .gaugeStyle(.linearCapacity)
            .tint(Gradient(colors: [.blue, .green]))
            
            

            ProgressView(value: loading, total: 200) {
                Text("Loading")
            } currentValueLabel: {
                Text("\(loading)")
            }

            Spacer()
        }
        .padding()
        .onAppear {
            Task {
                for i in 50...150 {
                    loading = Double(i)

                    try await Task.sleep(for: .milliseconds(20))
                }
            }
        }
    }
}


struct GaugeSpeed_Previews: PreviewProvider {
    static var previews: some View {
        GaugeSpeed()
    }
}
/*
import SwiftUI

struct WindDirectionGauge: View {
    var windDirectionDegrees: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 20)
            
            WindDirectionIndicator(degrees: windDirectionDegrees)
                .stroke(Color.blue, lineWidth: 10)
        }
        .frame(width: 200, height: 200)
    }
}

struct WindDirectionIndicator: Shape {
    var degrees: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        let indicatorLength = radius * 0.8
        let indicatorEndPoint = CGPoint(x: center.x + cos(degrees.toRadians()) * indicatorLength,
                                        y: center.y - sin(degrees.toRadians()) * indicatorLength)
        
        path.move(to: center)
        path.addLine(to: indicatorEndPoint)
        
        return path
    }
}

extension Double {
    func toRadians() -> CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

struct ContentView99: View {
    var weather: ResponseBody // Assuming you have the weather data
    
    var body: some View {
        VStack {
            // Other content here
            
            WindDirectionGauge(windDirectionDegrees: weather.wind.deg)
                .padding()
        }
    }
}

struct ContentView_Previews_09: PreviewProvider {
    static var previews: some View {
        ContentView99(weather: previewWeather) // Provide a sample weather data instance
    }
}
*/
/*
import SwiftUI
*/
struct WindDirectionGauge: View {
    var windDirectionDegrees: Double
    
    var body: some View {
        VStack {
            CompassMeter(pointerAngle: windDirectionDegrees)
                .frame(width: 200, height: 200)
        }
    }
}

struct CompassMeter: View {
    let numberOfIndicators = 36 // Number of indicators in the compass meter
    let pointerAngle: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<numberOfIndicators) { index in
                    Indicator()
                        .frame(width: 2, height: index % 9 == 0 ? 20 : 10) // Longer indicator for every 10th indicator
                        .offset(y: -geometry.size.height / 2)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(numberOfIndicators)))
                }
                
                RotatedArrow(angle: pointerAngle)
                    .frame(width: 10, height: 60) // Customize the arrow size
                    .offset(y: -geometry.size.height / 2)
            }
            .offset(y: geometry.size.height / 2) // Offset the entire compass to center the value and pointer
        }
        .foregroundColor(.gray.opacity(0.5))
    }
}

struct Indicator: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.red) // Change the color to white or any desired color
    }
}

struct RotatedArrow: View {
    var angle: Double
    
    var body: some View {
        Image(systemName: "arrow.up")
            .rotationEffect(.degrees(angle))
            .foregroundColor(.red) // Customize the arrow color
    }
}

struct ContentView12: View {
    var weather: ResponseBody // Assuming you have the weather data
    
    var body: some View {
        VStack {
            // Other content here
            
            WindDirectionGauge(windDirectionDegrees: weather.wind.deg)
                .padding()
        }
    }
}

struct ContentView_Previews12: PreviewProvider {
    static var previews: some View {
        ContentView12(weather: previewWeather) // Provide a sample weather data instance
    }
}

*/

/*
import SwiftUI

struct WindDirectionGauge: View {
    var windDirectionDegrees: Double
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                
                WindDirectionIndicator(degrees: windDirectionDegrees)
                    .stroke(Color.blue, lineWidth: 10)
            }
            .frame(width: 200, height: 200)
            
            Text("\(windDirectionDegrees)°")
                .font(.headline)
                .foregroundColor(.blue)
        }
    }
}

struct WindDirectionIndicator: Shape {
    var degrees: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        let indicatorLength = radius * 0.8
        let indicatorEndPoint = CGPoint(x: center.x + cos(degrees.toRadians()) * indicatorLength,
                                        y: center.y - sin(degrees.toRadians()) * indicatorLength)
        
        path.move(to: center)
        path.addLine(to: indicatorEndPoint)
        
        return path
    }
}

extension Double {
    func toRadians() -> CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

struct ContentView99: View {
    var weather: ResponseBody // Assuming you have the weather data
    
    var body: some View {
        VStack {
            // Other content here
            
            WindDirectionGauge(windDirectionDegrees: weather.wind.deg)
                .padding()
        }
    }
}

struct ContentView_Previews09: PreviewProvider {
    static var previews: some View {
        ContentView99(weather: previewWeather) // Provide a sample weather data instance
    }
}
*/


import SwiftUI

struct GaugeSpeed: View {
    @State var loading = 50.0

    var body: some View {
        VStack {
        

            Gauge(value: loading, in: 50...200) {
                Text("")
            } currentValueLabel: {
                Text("\(loading)")
            } minimumValueLabel: {
                Text("50")
                    .font(.system(size: 10))
            } maximumValueLabel: {
                Text("200")
                    .font(.system(size: 10))
            }
            .gaugeStyle(.linearCapacity)
            .tint(Gradient(colors: [.blue, .green]))

            Spacer()
        }
        .padding()
        .onAppear {
            Task {
                for i in 50...150 {
                    loading = Double(i)

                    try await Task.sleep(for: .milliseconds(20))
                }
            }
        }
    }
}


struct GaugeSpeed_Previews: PreviewProvider {
    static var previews: some View {
        GaugeSpeed()
    }
}


