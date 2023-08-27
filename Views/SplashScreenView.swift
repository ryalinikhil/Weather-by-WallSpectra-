//
//  SplashScreenView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 27/08/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @Binding var paywallPresented: Bool
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            DivideView(weather: previewWeather,paywallPresented: $paywallPresented)
        } else {
            VStack {
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                VStack(spacing: 20) {
                    Image("rm_logo")
                //    Text("Weather Wing")
                  //      .fontWeight(.bold)
                    //    .foregroundColor(.white.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.9
                        self.opacity = 1.00
                    }
                }
            }
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
/*
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}*/




////////////////////////////

/*
struct WelcomeView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        // Customize the welcome screen with your desired content and design
        ZStack{
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Button(action: {
                isPresented = false // Dismiss the welcome screen
            }) {
                ZStack{
                    Image("wbf") // Replace "backgroundImage" with the name of your image assetImage("Group 4")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 50) // Adjust the size of the button as needed
                    Text("Continue to WallSpectra")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

struct MainView: View {
    @State var show = false
  
    // Add this state variable to track if the welcome screen has been shown
    @State private var isWelcomeScreenPresented = false
    
    var button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    
    var body: some View {
        ZStack {
             Color.black.opacity(1.9)
                .ignoresSafeArea()
            
            
           

           
            
           
                }
                .onChange(of: isOpen) { newValue in
                    if newValue {
                        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                    } else {
                        UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                    }
                }
                .opacity(isLinkActive ? 0 : 1)
        }
        .sheet(isPresented: $isWelcomeScreenPresented, onDismiss: {
            // This closure will be executed when the welcome screen is dismissed
            UserDefaults.standard.set(true, forKey: "hasShownWelcomeScreen")
        }) {
            WelcomeView(isPresented: $isWelcomeScreenPresented)
        }
        .onAppear {
            // Check if the welcome screen has been shown before
            if !UserDefaults.standard.bool(forKey: "hasShownWelcomeScreen") {
                isWelcomeScreenPresented = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
*/
