//
//  NewView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 28/08/23.
//

import SwiftUI

struct NewView: View {
    var weather: ResponseBody
    var body: some View {
        ZStack{
            Image("imp")
                .ignoresSafeArea()
            NavigationView
            {
                ScrollView{
                    ZStack{
                        Image("imp")
                            .ignoresSafeArea()
                        
                        
                        
                        VStack(spacing:15){
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
                                VStack(spacing: 25) {
                                    
                                    HStack{
                                        
                                        Image(systemName: "mappin.and.ellipse")
                                            .renderingMode(.original)
                                            .foregroundColor(.blue)
                                            .font(.system(size:20))
                                        
                                        Text("LOCATION COORDINATES     ")
                                        
                                        Spacer()
                                    }
                                    
                                    // Text("")
                                    
                                    HStack(spacing: 32){
                                        VStack{
                                            Text("\(weather.coord.lat.description)")
                                                .font(.title.weight(.semibold))
                                            Text("Lattitude ")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.gray.opacity(1))
                                        }
                                        
                                        VStack{
                                            Text("\(weather.coord.lon.description)")
                                                .font(.title.weight(.semibold))
                                            Text("Longitude ")
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.gray.opacity(1))
                                        }
                                    }
                                    
                                    // Text("")
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                .frame(width: 342, height: 158)
                            }
                            // CITY VIEW
                            
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
                            //END OF CITY VIEW
                            // H_STACK BEGIN
                            HStack(spacing:15) {
                                
                                // DATE_VIEW_BEGINS
                                
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
                                            Image(systemName: "calendar")
                                            // .renderingMode(.original)
                                                .foregroundColor(.blue)
                                                .font(.system(size:19))
                                            
                                            Text("\(Date().formatted(.dateTime.month()))")
                                            
                                            Text("              ")
                                            
                                        }
                                        
                                        // MARK: Forecast Date
                                        Text("\(Date().formatted(.dateTime.day()))")
                                        //  .font(.title.weight(.semibold))
                                            .font(.system(size:45))
                                            .fontWeight(.medium)
                                        
                                        
                                        // MARK: Forecast Temperature
                                        // Text("\(Date().formatted(.dateTime.month().day().hour().minute()))")
                                        Text("\(Date().formatted(.dateTime.weekday()))")
                                            .font(.body)
                                            .fontWeight(.medium)
                                            .foregroundColor(Color.gray.opacity(1))
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 16)
                                    .frame(width: 165, height: 165)
                                }
                                
                                // END_OF_DATE_VIEW
                                // DEGREES START
                                
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
                                    
                                    Color.black
                                        .frame(width: 165, height: 165)
                                        .cornerRadius(30)
                                    // MARK: Content
                                    VStack(spacing: 10) {
                                        
                                        
                                        // MARK: Forecast Date
                                        ZStack{
                                            
                                            Image("dial")
                                                .scaleEffect(1.35)
                                            
                                            
                                            Text("  "+weather.wind.deg.roundDouble()+"°")
                                                .font(.title)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.red.opacity(0.9))
                                            
                                            
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 10)
                                    .frame(width: 165, height: 165)
                                }
                                
                                
                                
                                // DEGREE_END
                                
                            }
                            // HSTACK
                            HStack(spacing: 15){
                                
                                // meter temp
                                
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
                                    VStack(spacing: 30) {
                                        
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
                                            Text("")
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 7)
                                    .frame(width: 165, height: 175)
                                    
                                }
                                
                                // end meter
                                
                                // WATCH VIEW BEGINS
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
                                    
                                    
                                    Image("watch")
                                    
                                    Image(systemName: "xmark.icloud")
                                        .renderingMode(.original)
                                        .font(.system(size:29))
                                        .foregroundColor(.red.opacity(0.7))
                                    
                                    // MARK: Content
                                    VStack(spacing: 15) {
                                        
                                        HStack{
                                            Image(systemName: "exclamationmark.applewatch")
                                                .renderingMode(.original)
                                                .font(.system(size:19))
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 16)
                                    .frame(width: 165, height: 165)
                                }
                                //
                                //END OF WATCH VIEW
                            }
                            
                            
                            // LAST ROW
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
                                        
                                   /*     NavigationLink(destination: SettingsView()) {
                                            
                                            
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
                                        }
                                        */
                                        
                                        
                                        
                                    }
                                    
                                }
                                
                                Text("")
                                
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .frame(width: 342, height: 158)
                        }
                        
                    }//.padding(16)
                }//.padding(16)
            }
        }
    }
    }

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView(weather: previewWeather)
    }
}

