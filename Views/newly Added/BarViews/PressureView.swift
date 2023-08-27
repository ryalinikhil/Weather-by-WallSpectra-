//
//  PressureView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI

/*
struct PressureView: View {
    var weather: ResponseBody
    @State var loading = 1500.0
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 342, height: 158)
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
                    
                    Image(systemName: "gauge")
                        .renderingMode(.original)
                        .font(.system(size:20))
                        .foregroundColor(.teal)
                    Text("PRESSURE     ")
                        
                    Spacer()
                }
                
                Gauge(value: loading, in: 500...2000) {
                    Text(" Hectopascals (hPa)")
                        .font(.body)
                        .fontWeight(.medium)
                       // .foregroundColor(Color.gray.opacity(18.5))
                } currentValueLabel: {
                    Text("\(weather.main.pressure.roundDouble())")
                } minimumValueLabel: {
                    Text("500")
                        .font(.system(size: 10))
                } maximumValueLabel: {
                    Text("2000")
                        .font(.system(size: 10))
                }
                .gaugeStyle(.linearCapacity)
                //.tint(Gradient(colors: [.blue, .green]))
                .tint(Gradient(colors: [.blue.opacity(0.7),.blue.opacity(0.5), .purple.opacity(0.5), .purple.opacity(0.7), .purple]))
                // MARK: Forecast
                .onAppear {
                    Task {
                        for i in 500...1500 {
                            loading = Double(i)
                            try await Task.sleep(for: .milliseconds(1))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 342, height: 158)
        }
    }
}

// separate

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        CoordView(weather: previewWeather)
    }
}

struct CoordView: View {
    var weather: ResponseBody
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 342, height: 158)
                .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            
            Image("f_c")
              //  .opacity(0.6)
            
            Image("new_blur")
            
            MeteorView()

            // MARK: Content
            VStack(spacing: 15) {
                
                HStack{
                    
                    Image(systemName: "mappin.and.ellipse")
                        .renderingMode(.original)
                        .foregroundColor(.blue)
                        .font(.system(size:20))
                        
                         Text(" CITY")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white.opacity(1))
                    Spacer()
                }
                
               // Text("")
                
                HStack(spacing: 62){
                    VStack{
                        Text(weather.name)
                            .font(.title.weight(.bold))
                            //.font(.title(size:40))
                            .foregroundColor(Color.white.opacity(1))
                        
                    }
                    
                   
                        ZStack{
                            
                            Text(weather.main.tempMin.roundDouble() + "°C")
                                .font(.title.weight(.bold))
                                .foregroundColor(Color.white.opacity(0.9))
                           
                        }
                }
                
                Text("")
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 342, height: 158)
        }
    }
}
*/

/*
 NavigationView {
     VStack(spacing: 20) {
         NavigationLink(destination: FavoritesView()) {
             Text("Favorites")
                 .padding()
                 .background(Color.blue)
                 .foregroundColor(.white)
                 .cornerRadius(10)
         }
         
         NavigationLink(destination: PremiumView()) {
             Text("Premium")
                 .padding()
                 .background(Color.orange)
                 .foregroundColor(.white)
                 .cornerRadius(10)
         }
         
         NavigationLink(destination: SettingsView()) {
             Text("Settings")
                 .padding()
                 .background(Color.green)
                 .foregroundColor(.white)
                 .cornerRadius(10)
         }
         
         Spacer()
     }
     .navigationBarTitle("Side Menu Examples")
 }
 */

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        CoordView(weather: previewWeather)
    }
}

struct CoordView: View {
    var weather: ResponseBody
    var body: some View {
        NavigationView {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(0.2))
                .frame(width: 342, height: 148)
                .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                .overlay {
                    // MARK: Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
            
            
           // Image("f_c")
              //  .opacity(0.6)
            
         // Image("new_blur")
            
           // MeteorView()

            // MARK: Content
            VStack(spacing: 15) {
                
                        HStack(spacing: 6){
                            
                            NavigationLink(destination: FavoritesView()) {
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.forecastCardBackground.opacity(0.2))
                                        .frame(width: 100, height: 105)
                                        .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                                        .overlay {
                                            // MARK: Card Border
                                            RoundedRectangle(cornerRadius: 30)
                                                .strokeBorder(.white.opacity(0.5))
                                                .blendMode(.overlay)
                                        }
                                        .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
                                    
                                    Image("logo")
                                   //     .renderingMode(.original)
                                     //   .foregroundColor(.blue)
                                        .font(.system(size:29))
                                        .scaleEffect(0.8)
                                    
                                }
                            }
                            
                            NavigationLink(destination: PremiumView()) {
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.forecastCardBackground.opacity(0.2))
                                        .frame(width: 100, height: 105)
                                        .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                                        .overlay {
                                            // MARK: Card Border
                                            RoundedRectangle(cornerRadius: 30)
                                                .strokeBorder(.white.opacity(0.5))
                                                .blendMode(.overlay)
                                        }
                                        .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
                                    
                                    Image(systemName: "exclamationmark.bubble")
                                        .renderingMode(.original)
                                        .foregroundColor(.black)
                                        .font(.system(size:40))
                                    
                                }
                            }
                            
                      /*      NavigationLink(destination: SettingsView(paywallPresented: paywallPresented)) {
                                
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.forecastCardBackground.opacity(0.2))
                                        .frame(width: 100, height: 105)
                                        .shadow(color: .black.opacity(0.25), radius: 15, x: 5, y: 4)
                                        .overlay {
                                            // MARK: Card Border
                                            RoundedRectangle(cornerRadius: 30)
                                                .strokeBorder(.white.opacity(0.5))
                                                .blendMode(.overlay)
                                        }
                                        .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
                                    
                                    Image(systemName: "gear")
                                        //.renderingMode(.original)
                                        .foregroundColor(.black)
                                        .font(.system(size:40))
                                    
                                }
                            }*/
                            
                         
                        
                        
                    }
                   
                }
                
                Text("")
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 342, height: 158)
        }
    }
}
