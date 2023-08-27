//
//  SettingsView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 30/08/23.
//

import SwiftUI


/*
struct SettingsView_Previews90: PreviewProvider {
    static var previews: some View {
        PressureView(weather: previewWeather)
    }
}*/

import SwiftUI


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
                    
                    
                }
                
             
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: 342, height: 158)
        }
    }
}


import SwiftUI

struct ContentView11: View {
    var body: some View {
        NavigationView {
            HStack(spacing: 20) {
                NavigationLink(destination: FavoritesView()) {
                    Text("Favorites  ")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
                
                NavigationLink(destination: PremiumView()) {
                    Text("Premium  ")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
                
             /*   NavigationLink(destination: SettingsView()) {
                    Text("Settings  ")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }*/
                
                Spacer()
            }
            .navigationBarTitle("Side Menu Examples")
        }
    }
}

struct FavoritesView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
        ScrollView{
                Image("about")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}

struct PremiumView: View {
    let emailAddress = "adrenoxshark@gmail.com"

    var body: some View {
       
        ZStack{
           // Image("Variant3backdrop")
            VStack(spacing: 8) {
                Image("trail")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                ZStack{
                    Image("ag1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(0.72)
                    Link(" ", destination: URL(string: "mailto:\(emailAddress)")!)
                        .foregroundColor(.red)
                        .font(.headline)
                        .padding()
                }
            }
        }
    }
}

struct SettingsView123: View {
    var body: some View {
        ZStack {
            Color.black
            Text("Settings Content")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews11: PreviewProvider {
    static var previews: some View {
        ContentView11()
    }
}
/*
struct SettingsView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            NavigationView {
                VStack {
                    List {
                        Section(header: Text("General")) {
                            Link("Terms & Conditions", destination: URL(string: "https://www.freeprivacypolicy.com/live/490cc513-c48b-48e1-9140-de34549f3acd")!)
                            
                            Link("Privacy Policy", destination: URL(string: "https://www.freeprivacypolicy.com/live/d2c5c0ae-3f8f-4c94-b191-a27cf0f25222")!)
                        }
                        
                        Section(header: Text("Additional Information")) {
                            Link("Visit Our Website", destination: URL(string: "https://wallspectra.wixsite.com/home")!)
                                
                            Link("Rate App", destination: URL(string: "https://apps.apple.com/in/app/weather-by-wallspectra/id6463508279")!)
                                

                        }
                    }
                }
                .navigationBarTitle("Settings")
            }
        }
    }
}
*/

struct AboutView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                Spacer(minLength: 155)
                Image("about")
            }
        }
    }
}


struct PrivacySecurityView: View {
    var body: some View {
        NavigationView {
            Link("Visit Our Website", destination: URL(string: "https://www.example.com")!)
                .font(.headline)
                .padding()
            }
            .navigationBarTitle("Settings")
        }
    }




/*struct PrivacySecurityView: View {
    var body: some View {
        ZStack{
            Color.white
        ScrollView {
                VStack{
                    
                    
                }
            }
        }
        .navigationBarTitle("Privacy and Security")
        }
}*/

struct OurSiteView: View {
    var body: some View {
        VStack {
            Text("Our Site")
                .font(.title)
                .padding()
            
            Link("Visit Our Website", destination: URL(string: "https://www.example.com")!)
                .font(.headline)
                .padding()
        }
        .navigationBarTitle("Our Site")
    }
}

struct RateAppView: View {
    var body: some View {
        Text("Rate App")
            .navigationBarTitle("Rate App")
    }
}

struct SupportView: View {
    let emailAddress = "support@example.com"
    
    var body: some View {
        VStack {
           // Text("Contact Us")
            //    .font(.title)
             //   .padding()
            
            Link("Email Support", destination: URL(string: "mailto:\(emailAddress)")!)
                .font(.headline)
                .padding()
        }
        .navigationBarTitle("Contact Us")
    }
}
