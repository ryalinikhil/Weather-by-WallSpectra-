//
//  GageView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 30/08/23.
//
/*
import SwiftUI

struct GageView: View {
    @State var loading = 50.0
    var weather: ResponseBody
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 302, height: 148)
                .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            // MARK: Content
            VStack(spacing:25) {
                
                HStack{
                    
                    Image(systemName: "snowflake")
                     //   .renderingMode(.original)
                        .font(.system(size:20))     //sun.max.fill
                        .foregroundColor(.teal)
                    Text("     ")
                        
                    Spacer()
                    Image(systemName: "sun.max.fill")
                       // .renderingMode(.original)
                        .font(.system(size:20))     //sun.max.fill
                        .foregroundColor(.red.opacity(0.8))
                }
                
                Gauge(value: weather.main.temp, in: -30...50) {
                  //  Text(" ")
                    //    .font(.body)
                      //  .fontWeight(.medium)
                       // .foregroundColor(Color.gray.opacity(18.5))
                } currentValueLabel: {
                    Text("\(weather.main.temp.roundDouble())°C")
                } minimumValueLabel: {
                    Text("-30")
                        .font(.system(size: 10))
                } maximumValueLabel: {
                    Text("50")
                        .font(.system(size: 10))
                }
                .gaugeStyle(.linearCapacity)
                //.tint(Gradient(colors: [.blue, .green]))
                .tint(Gradient(colors: [.blue.opacity(0.7),.blue.opacity(0.5), .red.opacity(0.5), .red.opacity(0.7), .red]))
                // MARK: Forecast
                .onAppear {
                    Task {
                        for i in -30...50 {
                            loading = Double(i)
                            try await Task.sleep(for: .milliseconds(10))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 302, height: 148)
        }

    }
}

struct GageView_Previews: PreviewProvider {
    static var previews: some View {
        BouncingBallView()
    }
}
 */
/*
import SwiftUI
import SwiftUICharts
struct MaxTemView90: View {
   // @State private var isLoading = false
    var weather: ResponseBody = previewWeather
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 125, height: 165)
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
                
                
              //  MultiLineChartView(data: [([weather.main.temp], GradientColors.green), ([weather.main.humidity], GradientColors.purple), ([weather.main.temp], GradientColors.orngPink)], title: "Title")
                BarChartView(data: ChartData(values: [
                    ("Temperature", weather.main.temp),
                   ("Humidity", weather.main.humidity)
                ]), title: " ")
               //.frame(width: 110,height: 110)
              
               // ...
             //   BarChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", style: chartStyle)

            
                }
            }
        }
    }


*/
struct MaxTemView_Previews90: PreviewProvider {
    static var previews: some View {
        MovingBarChart()
    }
}

/*
import SwiftUI

struct MovingBarChart: View {
    @State private var barPosition: CGFloat = 0
    let animationDuration: Double = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 30, height: 70)
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Rectangle()
                    .frame(width: 30, height: 70)
                    .foregroundColor(.blue)
                    .offset(y: barPosition)
                    .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true))
            }
            
            Spacer()
        }
        .onAppear {
            animateBar()
        }
    }
    
    private func animateBar() {
        withAnimation {
            barPosition = -150
        }
    }
}

struct ContentView888: View {
    var body: some View {
        NavigationView {
            VStack {
                MovingBarChart()
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle("Moving Bar Chart")
        }
    }
}



 RoundedRectangle(cornerRadius: 30)
     .fill(Color.forecastCardBackground.opacity(0.2))
     .frame(width: 282, height: 148)
     .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
     .overlay {
         // MARK: Card Border
         RoundedRectangle(cornerRadius: 30)
             .strokeBorder(.white.opacity(0.5))
             .blendMode(.overlay)
     }
     .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
 */

import SwiftUI

struct MovingBarChart: View {
    @State private var barPosition: CGFloat = 0
    let animationDuration: Double = 0.7
    let movementRange: CGFloat = 50 // Adjust this value to control the movement range
    
    var body: some View {
        VStack {
           
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.forecastCardBackground.opacity(0.2))
                    .frame(width: 95, height: 169)
                    .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                    .overlay {
                        // MARK: Card Border
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(.white.opacity(0.5))
                            .blendMode(.overlay)
                    }
                    .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
                
                Rectangle()
                    .frame(width: 30, height: 150)
                    .foregroundColor(Color.blue.opacity(1.5))
                    .cornerRadius(30)
                
                Rectangle()
                    .frame(width: 30, height: 150)
                    .foregroundColor(.white)
                    .offset(y: barPosition)
                    .cornerRadius(30)
                    .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true))
            }
            
            Spacer()
        }
        .onAppear {
            animateBar()
        }
    }
    
    private func animateBar() {
        withAnimation {
            barPosition = -movementRange
        }
    }
}

struct ContentView99: View {
    var body: some View {
        NavigationView {
            VStack {
                MovingBarChart()
                    .padding()
                
                Spacer()
            }
            .navigationBarTitle("Moving Bar Chart")
        }
    }
}


