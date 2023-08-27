//
//  IntroView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 27/08/23.
//

import SwiftUI

struct IntroView: View {
    @Binding var isPresented: Bool
    @State private var isWelcomeScreenPresented = false
    var body: some View {
        ZStack{
            // Add your introductory content here (Text, Image, etc.)
            GeometryReader {
                let size = $0.size
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                    Image("main_1")
                        .resizable()
                        .aspectRatio (contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
            }
            
            VStack {
                Spacer()
                Button(action: {
                    // Button action
                    isPresented = false
                }) {
                    ZStack{
                        Image("frwd")
                    }
                }
                .padding(.bottom)
                    }
                
                }
            }
        }
/*
struct IntroView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Welcome to My Weather App")
                .font(.title)
                .padding()
            
            Text("This is an introduction to your app.")
                .padding()
            
            Button("Continue") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}




VStack{
    Spacer(minLength: 295)
    HStack{
   //     Spacer(minLength: 85)
        Button(action: {
            isPresented = false // Dismiss the welcome screen
        }) {
            ZStack{
                // Image("wbf") // Replace "backgroundImage" with the name of your image assetImage("Group 4")
                //     .resizable()
                //     .scaledToFill()
                //    .frame(width: 200, height: 50) // Adjust the size of the button as needed
                
                Image("continue_button")
                
            }
        }
    }
}
*/
