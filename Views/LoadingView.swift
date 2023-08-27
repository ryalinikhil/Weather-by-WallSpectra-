//
//  LoadingView.swift
//  TestWeather
//
//  Created by Sameer Nikhil on 26/08/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            
            Color.black
                .ignoresSafeArea()
            
            Image("load")
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fit)
                
            VStack{
                
                Text("")
                Text("")
                Text("")
                
                ProgressView()
                {
                    VStack(spacing: 8){
                        
                        Text("Fetching Your Location")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                }
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
