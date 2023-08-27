//
//  WelcomeView.swift
//  TestWeather
//
//  Created by Sameer Nikhil on 26/08/23.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager:LocationManager
    
    
    var body: some View {
        ZStack(alignment: .center){
            Image("blue_background")
                .resizable()
                .ignoresSafeArea()
            HStack{

                GeometryReader {
                    let size = $0.size
                    ZStack{
                        Image("1.1.weather")
                            .resizable()
                            .aspectRatio (contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                        //Spacer(minLength: 25)
                        VStack{
                            LocationButton (.shareCurrentLocation) {
                                locationManager.requestLocation ( )
                            }
                            .cornerRadius(30)
                            .symbolVariant(.fill)
                            .foregroundColor (.white)
                            .offset(y:225)
                            .frame( alignment: .center)
                        }
                    }
                    //  }
                }
                //   .frame( alignment: .center)
                //Spacer(minLength: 25)
            }
        }
    }
}



