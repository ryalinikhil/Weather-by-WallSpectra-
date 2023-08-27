//
//  Weather_by_WallSpectraApp.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 27/08/23.
//

import FirebaseCore
import SwiftUI
import RevenueCat


/*

@main
struct Weather_by_WallSpectraApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
   
    init() {
      //  FirebaseApp.configure()
        /* Enable debug logs before calling `configure`. */
        Purchases.logLevel = .debug
        
        /*
         Initialize the RevenueCat Purchases SDK.
         
         - `appUserID` is nil by default, so an anonymous ID will be generated automatically by the Purchases SDK.
            Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids
         
         - `observerMode` is false by default, so Purchases will automatically handle finishing transactions.
            Read more about Observer Mode here: https://dz gocs.revenuecat.com/docs/observer-mode
         */

        Purchases.configure(
            with: Configuration.Builder(withAPIKey: Constants.apiKey)
                .with(usesStoreKit2IfAvailable: true)
                .build()
        )

        /* Set the delegate to our shared instance of PurchasesDelegateHandler */
        Purchases.shared.delegate = PurchasesDelegateHandler.shared
    }
   
    
  var body: some Scene {
      @Binding var paywallPresented: Bool
    WindowGroup {
     
       // ContentView()
        DivideView(weather: previewWeather, paywallPresented: $paywallPresented)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
*/


import SwiftUI
import Firebase
import RevenueCat

@main
struct Weather_by_WallSpectraApp: App {
// @StateObject var vm = DataManager()

    init() {
        FirebaseApp.configure()
        /* Enable debug logs before calling `configure`. */
        Purchases.logLevel = .debug
        
        /*
         Initialize the RevenueCat Purchases SDK.
         
         - `appUserID` is nil by default, so an anonymous ID will be generated automatically by the Purchases SDK.
            Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids
         
         - `observerMode` is false by default, so Purchases will automatically handle finishing transactions.
            Read more about Observer Mode here: https://dz gocs.revenuecat.com/docs/observer-mode
         */

        Purchases.configure(
            with: Configuration.Builder(withAPIKey: Constants.apiKey)
                .with(usesStoreKit2IfAvailable: true)
                .build()
        )

        /* Set the delegate to our shared instance of PurchasesDelegateHandler */
        Purchases.shared.delegate = PurchasesDelegateHandler.shared
    }
    
    
    
    var body: some Scene {
        WindowGroup {
            
            
            
           // SplashScreenView()
            
            
            
             ContentView()
            //   .environmentObject(vm)
           // Paywall(isPaywallPresented: .constant(false))      }
               /* ContentView()
                    .preferredColorScheme(.dark)
                    .task {
                        do {
                            // Fetch the available offerings
                            UserViewModel.shared.offerings = try await Purchases.shared.offerings()
                        } catch {
                            print("Error fetching offerings: \(error)")
                        }
                    } */
            }
    }
    
    
}





