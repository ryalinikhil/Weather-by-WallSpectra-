//
//  ContentView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 27/08/23.
//


import SwiftUI
import RevenueCat


struct ContentView: View {
    @State private var showIntro = true
    var weatherManager = WeatherManager()
    @StateObject var locationManager = LocationManager()
    @State var weather: ResponseBody?
    @State private var isWelcomeScreenPresented = false
    var body: some View {
        VStack{
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(action: {}, weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .sheet(isPresented: $isWelcomeScreenPresented, onDismiss: {
            // This closure will be executed when the welcome screen is dismissed
            UserDefaults.standard.set(true, forKey: "hasShownWelcomeScreen")
        }) {
            IntroView(isPresented: $isWelcomeScreenPresented)
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
        ContentView()
    }
}




 

import RevenueCat
import SwiftUI

struct DivideView: View {
    var weather: ResponseBody
    @Binding var paywallPresented: Bool
   // @State var paywallPresented = false
    @State private var isSettingsViewPresented = false
    @ObservedObject var userModel = UserViewModel.shared
    @State private var isPresented = false
    var body: some View {
     NavigationView {
     ZStack{
     Image("bgi")
     .resizable()
     //.aspectRatio(contentMode: .fill)
     .ignoresSafeArea()
     GeometryReader { geometry in
     let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
     let imageOffset = screenHeight + 36
     
     VStack
     {
     Text("")
     
     
     Text(weather.name)
     .font(.largeTitle)
     .foregroundColor(Color.blue)
     
     Text(" " + weather.main.temp.roundDouble() + "°")
     .font(.system(size:90))
     .foregroundStyle(.blue)
     
     
     HStack{
     Spacer()
     Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
     .fontWeight(.semibold)
     .font(.title3.weight(.semibold))
     .foregroundColor(Color.blue)
     Spacer()
     }
     
     Spacer()
     
     
     
     VStack(spacing:10){
     
     
     ZStack {
     RoundedRectangle(cornerRadius: 20)
     .fill(Color.probabilityText.opacity(0.2))
     .frame(width: 325, height: 165)
     .shadow(color: .white.opacity(0.25), radius: 15, x: 5, y: 4)
     .overlay {
     // MARK: Card Border
     RoundedRectangle(cornerRadius: 30)
     .strokeBorder(.black.opacity(0.5))
     .blendMode(.overlay)
     }
     .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
     
     // MARK: Content
     
     
  
         
    // Forecast Button
         
         
     VStack(spacing: 23) {
     
     HStack{
     Image(systemName: "cloud.sun.fill")
     .renderingMode(.original)
     .font(.system(size:23))
     .foregroundColor(.blue)
     
     Text("GET FULL FORECAST")
     .foregroundColor(Color.blue)
     }
     
     VStack{
     
         
         // Forecast Button                                                                             // Button
         
         
     Button(action: {
     self.performMagic()
     // Action to be performed when the button is tapped
     }) {
     ZStack{
     
     RoundedRectangle(cornerRadius: 30)
     .fill(Color.probabilityText.opacity(0.2))
     .frame(width: 205, height: 65)
     .shadow(color: .blue.opacity(0.25), radius: 15, x: 5, y: 4)
     .overlay {
     // MARK: Card Border
     RoundedRectangle(cornerRadius: 30)
     .strokeBorder(.black.opacity(0.5))
     .blendMode(.overlay)
     }
     .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendMode: .overlay)
     
     Text("Forecast")
     .foregroundColor(.blue)
     .font(.title3.weight(.semibold))
     
     }
     }
     .padding()
     .background(
        NavigationLink(destination: ContentView( weather: weather), isActive: $isPresented) {
                                 EmptyView()
                             }
                            
                         )
     }
     }
     .padding(.horizontal, 8)
     .padding(.vertical, 7)
     .frame(width: 225, height: 180)
     
     }
     
     
     
     // Location Symbol
     
     HStack{
     
     Button {
         self.performMagic()
     } label: {
     Image(systemName: "location.north.circle.fill")
     .foregroundColor(.blue.opacity(0.9))
     .frame(width: 45, height: 45)
     .scaleEffect(1.7)
     
     }
     .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
     
     Spacer()
     
         
         
        // Gear Symbol
         
         
     Button(action: {
     // Action to be performed when the button is tapped
     }) {
   //  NavigationLink(destination: UserView(paywallPresented: $paywallPresented)) {
         NavigationLink(destination: UserView(paywallPresented: $paywallPresented)) {
     ZStack{
     
     Image(systemName: "gear")
     .foregroundColor(.blue.opacity(0.9))
     .frame(width: 45, height: 45)
     .scaleEffect(1.7)
     }
     }
     }
     .padding()
     
     Text("")
     // Spacer()
     
     }
         }
     .ignoresSafeArea()
     
     }
     }
     }
     }
     }
    private func performMagic() {
        /*
         We should check if we can magically change the weather (subscription active) and if not, display the paywall.
         */
        if self.userModel.subscriptionActive {
            // Navigate to HomeView if subscription is active
            self.isPresented.toggle()
        } else {
           // self.paywallPresented.toggle()
            self.isPresented.toggle()
        }
    }
     
     }






struct MainView: View {
    
    /* State to determine whether the paywall modal is displayed. */
    @State var paywallPresented = false
    @State private var isWelcomeScreenPresented = false
    var body: some View {
        TabView {
            NavigationView {
              //  MainView(paywallPresented: $paywallPresented)
                DivideView(weather: previewWeather, paywallPresented: $paywallPresented)
               // MainView(paywallPresented: $paywallPresented)
                //    .environmentObject(DataManager())
                    .navigationTitle("Feng Wallaper")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "house.circle.fill")
                Text("Home")
            }
            
            NavigationView {
                UserView(paywallPresented: $paywallPresented)
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "person.circle.fill")
                Text("User")
            }
        }
        .sheet(isPresented: $paywallPresented, content: {
            PaywallView(isPresented: $paywallPresented)
        })
        
        .sheet(isPresented: $isWelcomeScreenPresented, onDismiss: {
            // This closure will be executed when the welcome screen is dismissed
            UserDefaults.standard.set(true, forKey: "hasShownWelcomeScreen")
        }) {
            IntroView(isPresented: $isWelcomeScreenPresented)
        }
        .onAppear {
            // Check if the welcome screen has been shown before
            if !UserDefaults.standard.bool(forKey: "hasShownWelcomeScreen") {
                isWelcomeScreenPresented = true
            }
        }
        
    }
}





struct UserView: View {
    @ObservedObject var model = UserViewModel.shared
    @State private var isShowingPopup = false
    @State private var newUserId: String = ""
    @State private var isViewVisible = false
    @Binding var paywallPresented: Bool
    @ObservedObject var userModel = UserViewModel.shared
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Current User")) {
                    HStack {
                        Image("Fing_logo")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                        Text("User Identifier")
                            .font(.headline)
                    }
                    Button(action: {
                        isShowingPopup = true
                    }) {
                        Text("Get User ID")
                            .font(.headline)
                         //  .padding()
                    }
                    .alert(isPresented: $isShowingPopup) {
                        Alert(title: Text("User ID"), message: Text(Purchases.shared.appUserID), dismissButton: .default(Text("OK")))
                    }
                    HStack {
                        Text("Subscription Status")
                            .font(.headline)
                        Spacer()
                        Text(model.subscriptionActive ? "Active" : "Not Active")
                            .foregroundColor(model.subscriptionActive ? .green : .red)
                    }
                }

                Section(header: Text("Authentication")) {
                    if !Purchases.shared.isAnonymous {
                        Button(action: {
                            Task {
                                await model.logout()
                            }
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 64.0)
                        }
                    } else {
                        TextField("Enter User ID", text: $newUserId, onCommit: {
                            guard !self.newUserId.isEmpty else { return }
                            _ = Task { await self.model.login(userId: newUserId) }
                            self.newUserId = ""
                        })
                        .multilineTextAlignment(.center)
                        .padding(.top, 8.0)
                        Spacer()
                    }
                }

                
                Section(header: Text("Actions")) {
                    Button(action: {
                        Task {
                            try? await Purchases.shared.restorePurchases()
                        }
                    }) {
                        Text("Restore Purchases")
                            .foregroundColor(.green)
                            //.font(.headline)
                           // .frame(maxWidth: .infinity, minHeight: 64.0)
                    }

                    Button(action: {
                                   withAnimation {
                                       self.isViewVisible.toggle()
                                   }
                               }) {
                                   Text("Premium")
                                       .foregroundColor(.blue)
                                       
                               }
                               
                               if isViewVisible {
                                   BottomView(paywallPresented: $paywallPresented)
                                       .transition(.move(edge: .bottom))
                               }
                    
                    Button(action: {
                        let emailAddress = "support@example.com"
                        if let emailURL = URL(string: "mailto:\(emailAddress)") {
                            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
                        }
                    }) {
                        Text("Contact Support")
                         //  .font(.headline)
                            .foregroundColor(.blue)
                           // .padding()
                            .cornerRadius(10)
                    }
                }
                
                
                
              
                    Section(header: Text("General")) {
                        
                        Link("Terms of Use (EULA)", destination: URL(string: "https://www.eulatemplate.com/live.php?token=9bhmDEmZlMZb1cGhb8fKhGqV5LV79f4A")!)
                        
                        
                        Link("Privacy Policy", destination: URL(string: "https://www.privacypolicies.com/live/32ac372b-f010-42b6-8855-b863d71f2a80")!)
                    }
                    
                    Section(header: Text("Additional Information")) {
                        Link("Visit Our Website", destination: URL(string: "https://wallspectra.wixsite.com/home")!)
                            
                        Link("Rate App", destination: URL(string: "https://apps.apple.com/in/app/")!)
                            // Replace here with your App link

                    }
                
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings")
    
        }
    }
}



struct SettingsView: View {
    @Binding var paywallPresented: Bool
    @ObservedObject var userModel = UserViewModel.shared
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



struct BottomView: View {
    @Binding var paywallPresented: Bool
    @ObservedObject var userModel = UserViewModel.shared
    var body: some View {
        ZStack {
            
            Image("pre_compressed")
                .resizable()
                .aspectRatio(contentMode: .fill)
            .cornerRadius(10)}
        .frame(maxWidth: .infinity)
        .background(Color.white)
        
        Button{
            self.paywallPresented.toggle()
          //  vm.animateCircle.toggle()
          //  vm.downloadansSaveImage(url: vm.selectedImage ?? "")
        } label: {
            Text("Get Premium")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
    }
}


















/**/


//   ---------- Main one ----------- Above --------------
/*
 
 
struct ContentView: View {
    var weatherManager = WeatherManager()
    @StateObject var locationManager = LocationManager()
        //var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                      WeatherView(weather: weather)
                    //  Text(" weater fetched")
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

    

import SwiftUI
struct ContentView: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    var weatherManager = WeatherManager()
    @StateObject var locationManager = LocationManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        Group {
            if !hasLaunchedBefore {
                IntroView()
                    .onAppear {
                        hasLaunchedBefore = true
                    }
            } else if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

*/
/*
func isFirstLaunch() -> Bool {
    let hasBeenLaunchedBefore = UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore")
    if !hasBeenLaunchedBefore {
        UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBefore")
    }
    return !hasBeenLaunchedBefore
}

    
  */
    
 


