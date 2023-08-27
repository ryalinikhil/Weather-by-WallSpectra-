//
//  WeatherView.swift
//  TestWeather
//
//  Created by Sameer Nikhil on 26/08/23.
//

import SwiftUI
import BottomSheet
import SwiftUICharts


enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct WeatherView: View {
    
    @State private var isPresented = false
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    @State private var selection = 0
    @State var loading = 500.0
    @StateObject var locationManager = LocationManager()
  //  @Binding var selection: Int
     var action: () -> Void
    // Replace YOUR_API_KEY in WeatherManager with your own API key for the app to work
    var weather: ResponseBody
    // Bottom sheet Animation Transaltion
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack {
                    
                    // MARK: Background Color
                    Image("blue_background")
                        .resizable()
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                      //  .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // MARK: Current Weather
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                            Text(weather.name)
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                        VStack {
                            Text(attributedString)
                               // .foregroundColor(.white)
                            
                            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                .fontWeight(.semibold)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(Color.white)
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    
                    // MARK: Bottom Sheet
                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationProrated.formatted())
                    } content: {
                       // ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                        ScrollView {
                            VStack(spacing: 0) {
                                // MARK: Segmented Control
                                SegmentedControl(selection: $selection)
                                // MARK: Forecast Cards
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 28) {
                                        if selection == 0 {
                                            
                                            HStack(spacing: 6){
                                                
                                                ForEach(Forecast.hourly) { forecast in
                                                    ForecastCard(forecast: forecast, forecastPeriod: .hourly, weather: previewWeather )
                                                }
                                                
                                                // second Box
                                                
                                                ZStack {
                                                    // MARK: Card
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .fill(Color.forecastCardBackground.opacity(0.2))
                                                        .frame(width: 170, height: 150)
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
                                                            
                                                            Image(systemName: "thermometer")
                                                                .renderingMode(.original)
                                                                .font(.system(size:19))
                                                                .foregroundColor(.teal)
                                                            Text(" TEMP     ")
                                                                .foregroundColor(Color.white)
                                                                
                                                        }
                                                        
                                                        // MARK: Forecast
                                                        HStack{
                                                            Text( weather.main.temp.description + "°C")
                                                                .font(.title.weight(.semibold))
                                                                .foregroundColor(Color.white)
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                        
                                                        // MARK: Forecast Max Temperature
                                                       // Text("Least Temparature ")
                                                      //      .font(.body)
                                                       //     .fontWeight(.medium)
                                                        //    .foregroundColor(Color.gray.opacity(1))
                                                        let temperatureCelsius = weather.main.temp
                                                        let temperatureFahrenheit = (temperatureCelsius * 9/5) + 32

                                                        Text(String(format: "%.2f°F", temperatureFahrenheit))
                                                            .font(.title.weight(.semibold))
                                                            .foregroundColor(Color.white)
                                                    }
                                                    .padding(.horizontal, 16)
                                                    .padding(.vertical, 16)
                                                    .frame(width: 180, height: 150)
                                                }

                                                
                                                // end of second box
                                                
                                                //3rd box
                                                
                                                MovingBarChart()
                                                    .scaleEffect(0.9)
                                                
                                                
                                                // end of 3rd box
                                            }
                                            
                                            .transition(.offset(x: -430))
                                        } else {
                                            HStack{
                                                //FIRST_ONE
                                                ForEach(Forecast.daily) {
                                                    forecast in
                                                    ForecastCard(forecast: forecast, forecastPeriod: .daily, weather: previewWeather)
                                                }
                                                //END_OFDAY
                                                
                                                // METR_TEMP_LOAD_START
                                                ZStack {
                                                    // MARK: Card
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
                                                                .foregroundColor(Color.white)
                                                        } minimumValueLabel: {
                                                            Text("-30")
                                                                .font(.system(size: 10))
                                                                .foregroundColor(Color.white)
                                                        } maximumValueLabel: {
                                                            Text("50")
                                                                .font(.system(size: 10))
                                                                .foregroundColor(Color.white)
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
                                                    .frame(width: 282, height: 148)
                                                }
                                                //METER_TEMP_LOAD STOP
                                                
                                            }
                                            .transition(.offset(x: 430))
                                        }
                                    }
                                    .padding(.vertical, 20)
                                }
                                .padding(.horizontal, 20)
                                
                                // MARK: Forecast Widgets
                                VStack(spacing: 15) {
                                    
                                    HStack(spacing: 15){
                                        
                                        // MINIMUM TEMPARATURE
                                        
                                        Button(action: {
                                            // Action to perform when the button is tapped
                                        })
                                        {
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
                                                        
                                                        Image(systemName: "thermometer.low")
                                                            .renderingMode(.original)
                                                            .font(.system(size:19))
                                                        Text("MIN TEMP     ")
                                                            .foregroundColor(Color.white)
                                                        
                                                    }
                                                    
                                                    // MARK: Forecast
                                                    HStack{
                                                        Text(weather.main.tempMin.roundDouble() + "°C")
                                                            .font(.title.weight(.semibold))
                                                            .foregroundColor(Color.white)
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal)
                                                    
                                                    // MARK: Forecast Max Temperature
                                                    Text("Least Temparature ")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(Color.gray.opacity(1))
                                                }
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 16)
                                                .frame(width: 165, height: 175)
                                            }
                                        }
                                        
                                        //MAXIMUM TEMPARATURE
                                        //MaxTemView(weather: previewWeather)
                                        
                                        Button(action: {
                                            // Action to perform when the button is tapped
                                        })
                                        {
                                            
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
                                                        
                                                        Image(systemName: "thermometer.high")
                                                            .renderingMode(.original)
                                                            .font(.system(size:19))
                                                        Text("MAX TEMP     ")
                                                            .foregroundColor(Color.white)
                                                        
                                                    }
                                                    
                                                    // MARK: Forecast
                                                    HStack{
                                                        Text(weather.main.tempMax.roundDouble() + "°C")
                                                            .font(.title.weight(.semibold))
                                                            .foregroundColor(Color.white)
                                                        //.font(.title.weight(.semibold))
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal)
                                                    
                                                    // MARK: Forecast Max Temperature
                                                    Text("Peak Temparature ")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(Color.gray.opacity(1))
                                                }
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 16)
                                                .frame(width: 165, height: 175)
                                            }
                                        }
                                        // END OF MAX_TEMP
                                    }
                                    .padding(.horizontal)
                                    
                                    HStack(spacing: 15){
                                        //  WindSpeedView(weather: previewWeather)
                                        //WINDSPEEDVIEW
                                        
                                        Button(action: {
                                            // Action to perform when the button is tapped
                                        })
                                        
                                        {
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
                                                        
                                                        Text("WIND SPEED ")
                                                            .foregroundColor(Color.white)
                                                        
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
                                        
                                        //END OF WINDSPEED_VIEW
                                        
                                        //FEELS LIKE VIEW
                                        //ForecastCardB( weather: previewWeather)
                                        
                                        Button(action: {
                                            // Action to perform when the button is tapped
                                        })
                                        {
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
                                                        Image(systemName: "thermometer.sun.fill")
                                                            .renderingMode(.original)
                                                            .font(.system(size:19))
                                                        
                                                        Text("FEELS LIKE    ")
                                                            .foregroundColor(Color.white)
                                                        
                                                    }
                                                    
                                                    // MARK: Forecast Date
                                                    Text(weather.main.feelsLike.roundDouble() + "°C")
                                                        .font(.title.weight(.semibold))
                                                        .foregroundColor(Color.white)
                                                    
                                                    /*  VStack(spacing: -4) {
                                                     // MARK: Forecast Small Icon
                                                     Image("\(forecast.icon) small")
                                                     
                                                     // MARK: Forecast Probability
                                                     
                                                     }
                                                     .frame(height: 42)*/
                                                    
                                                    // MARK: Forecast Temperature
                                                    Text("Similar to actual Temparature")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(Color.gray.opacity(1))
                                                }
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 16)
                                                .frame(width: 165, height: 175)
                                            }
                                        }
                                        
                                        //END OF FEELS_LIKE
                                        
                                    }
                                    .padding(.horizontal)
                                    
                                    // VSTACK_START_OF_PRESSURE_VIEW
                                    //  PressureView(weather: previewWeather)
                                    
                                    Button(action: {
                                        // Action to perform when the button is tapped
                                        self.isPresented = true
                                    })
                                    {
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
                                                    .foregroundColor(Color.white)
                                                
                                                Spacer()
                                            }
                                            
                                            Gauge(value: weather.main.pressure, in: 0...2000) {
                                                Text(" Hectopascals (hPa)")
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color.white)
                                                // .foregroundColor(Color.gray.opacity(18.5))
                                            } currentValueLabel: {
                                                Text("\(weather.main.pressure.roundDouble())")
                                                    .foregroundColor(Color.white)
                                            } minimumValueLabel: {
                                                Text("0")
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
                                                    for i in 0...2000 {
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
                                    //     .sheet(isPresented: $isPresented) {
                                      //    OtherView()
                                    //           }
                                    // END_OF_PRESSURE_VIEW
                                    // START_OD_LAST ROW OF HSTACK
                                    HStack(spacing: 15){
                                        
                                        
                                        // HumidityView( weather: previewWeather)
                                        //START_OF_HUMIDITY_VIEW
                                        
                                        Button(action: {
                                            // Action to perform when the button is tapped
                                        })
                                        {
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
                                                        
                                                        Image(systemName: "humidity.fill")
                                                            .renderingMode(.original)
                                                            .foregroundColor(.blue)
                                                            .font(.system(size:19))
                                                        Text("HUMIDITY        ")
                                                            .foregroundColor(Color.white)
                                                        
                                                    }
                                                    
                                                    // MARK: Forecast Date
                                                    HStack{
                                                        Text(weather.main.humidity.roundDouble() + "%")
                                                            .font(.title.weight(.semibold))
                                                            .foregroundColor(Color.white)
                                                        
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal)
                                                    /*  VStack(spacing: -4) {
                                                     // MARK: Forecast Small Icon
                                                     Image("\(forecast.icon) small")
                                                     
                                                     WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                                                     }
                                                     
                                                     // MARK: Forecast Probability
                                                     
                                                     }
                                                     .frame(height: 42)*/
                                                    
                                                    // MARK: Forecast Temperature
                                                    Text("Ongoing      Air Dampness ")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(Color.gray.opacity(1))
                                                }
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 16)
                                                .frame(width: 165, height: 175)
                                            }
                                        }
                                        //END _OF_HUMIDITY_VIEW
                                        // START OF AQI[AIR QUALITY INDEX VIEW]
                                        //AqiView(weather: previewWeather)
                                        
                                        Button(action: {
                                            // Action to perform when the button is tapped
                                        })
                                        {
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
                                                        .foregroundColor(Color.white)
                                                    
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
                                        
                                        //END OF AQI_VIEW
                                    }
                                    .padding(.horizontal)
                                                
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                    .opacity(bottomSheetTranslationProrated)
                            }
                        }
                        .backgroundBlur(radius: 25, opaque: true)
                        .background(Color.bottomSheetBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 44))
                        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationProrated)
                        .overlay {
                            // MARK: Bottom Sheet Separator
                            Divider()
                                .blendMode(.overlay)
                                .background(Color.bottomSheetBorderTop)
                                .frame(maxHeight: .infinity, alignment: .top)
                                .clipShape(RoundedRectangle(cornerRadius: 44))
                        }
                        .overlay {
                            // MARK: Drag Indicator
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black.opacity(0.3))
                                .frame(width: 48, height: 5)
                                .frame(height: 20)
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                    
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                    }
                    
                    // MARK: Tab Bar
                    // START_OF_TAB_BAR
                    ZStack {
                        // MARK: Arc Shape
                        Arc()
                            .fill(Color.tabBarBackground)
                            .frame(height: 88)
                            .overlay {
                                // MARK: Arc Border
                                Arc()
                                    .stroke(Color.tabBarBorder, lineWidth: 0.5)
                            }
                        
                        // MARK: Tab Items
                        HStack {
                            // MARK: Expand Button
                            Button {
                                action()
                            } label: {
                                Image(systemName: "location.north.circle.fill")
                                    .foregroundColor(.white.opacity(0.9))
                                    .frame(width: 45, height: 45)
                            }
                            
                            Spacer()
                            
                            // MARK: Navigation Button
                            NavigationLink {
    
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
                                                            .foregroundColor(Color.white)
                                                        Spacer()
                                                    }
                                                    
                                                    // Text("")
                                                    
                                                    HStack(spacing: 32){
                                                        VStack{
                                                            Text("\(weather.coord.lat.description)")
                                                                .font(.title.weight(.semibold))
                                                                .foregroundColor(Color.white)
                                                            Text("Lattitude ")
                                                                .font(.body)
                                                                .fontWeight(.medium)
                                                                .foregroundColor(Color.gray.opacity(1))
                                                        }
                                                        
                                                        VStack{
                                                            Text("\(weather.coord.lon.description)")
                                                                .font(.title.weight(.semibold))
                                                                .foregroundColor(Color.white)
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
                                                
                                              //  MeteorView()
                                                
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
                                                .frame(width: 347, height: 158)
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
                                                            .foregroundColor(Color.gray.opacity(1))
                                                        
                                                        
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
                                                                .foregroundColor(Color.white)
                                                            
                                                        }
                                                        
                                                        VStack{
                                                            Gauge(value: weather.main.temp, in: -30...50) {
                                                                Text("Loading")
                                                                    .foregroundColor(Color.white)
                                                            } currentValueLabel: {
                                                                Text(weather.main.temp.roundDouble() + "°C")
                                                                    .font(.system(size: 10))
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(Color.white)
                                                            } minimumValueLabel: {
                                                                Text("-30")
                                                                    .font(.system(size: 10))
                                                                    .foregroundColor(Color.white)
                                                            } maximumValueLabel: {
                                                                Text("50")
                                                                    .font(.system(size: 10))
                                                                    .foregroundColor(Color.white)
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
                                                    
                                                    HStack(spacing: 9){
                                                        
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
                                                                
                                                                Image("rm_logo")
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
                                                                    .foregroundColor(.white)
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
                                                                    .foregroundColor(.white)
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
                                           // .frame(width: 342, height: 158)
                                        }
                                        
                                    }.padding(16)
                                }
                        
                                
                            } label: {
                                Image(systemName: "globe.central.south.asia.fill")
                                    .foregroundColor(.white.opacity(0.9))
                                    .frame(width: 45, height: 45)
                            }
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                    .offset(y: bottomSheetTranslationProrated * 115)
                    //
                    // END_OF_TAB_BAR
                   // MeteorView()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString(weather.main.temp.roundDouble() + "°" + (hasDragged ? " | " : "\n ") + "     Celsius")
        
        if let temp = string.range(of: weather.main.temp.roundDouble() + "°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "  Celsius") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}



struct WeatherView_Previews2: PreviewProvider {
    static var previews: some View {
        WeatherView(action: {}, weather: previewWeather)
            .preferredColorScheme(.dark)
    }
}


/*
import SwiftUI


struct WeatherView: View {
    // Replace YOUR_API_KEY in WeatherManager with your own API key for the app to work
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    Spacer()
                                           .frame(height:  80)
                                       
                                       AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                                           image
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 350)
                                       } placeholder: {
                                           ProgressView()
                                       }
                                       
                                       Spacer()
                                   }
                                   .frame(maxWidth: .infinity, alignment: .trailing)
                               }
                               .padding()
                               .frame(maxWidth: .infinity, alignment: .leading)
                               
                               VStack {
                                   Spacer()
                                   VStack(alignment: .leading, spacing: 20) {
                                       Text("Weather now")
                                           .bold()
                                           .padding(.bottom)
                                       
                                       HStack {
                                           WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                                           Spacer()
                                           WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                                       }
                                       HStack {
                                                              WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                                                              Spacer()
                                                              WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                                                          }
                                                      }
                                                      .frame(maxWidth: .infinity, alignment: .leading)
                                                      .padding()
                                                      .padding(.bottom, 20)
                                                      .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                                                      .background(.white)
                                                      .cornerRadius(20, corners: [.topLeft, .topRight])
                                                  }
                                              }
                                              .edgesIgnoringSafeArea(.bottom)
                                              .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                                              .preferredColorScheme(.dark)
                                          }
                                      }


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
*/
/*
import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.385 // 325/844
}

struct WeatherView: View {
    var weather: ResponseBody
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                ZStack {
                    // MARK: Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // MARK: House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // MARK: Current Weather
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                            
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    
                    // MARK: Bottom Sheet
                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationProrated.formatted())
                    } content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                    }
                    
                    // MARK: Tab Bar
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
            .preferredColorScheme(.dark)
    }
}
*/




struct OtherView: View {

    var body: some View {
        Text("°C")
    }
}
                                                                                                                        
