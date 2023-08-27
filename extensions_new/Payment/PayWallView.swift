//
//  PayWallView.swift
//  MagicWallpaper
//
//  Created by Sameer Nikhil on 11/10/23.
//

import SwiftUI
import RevenueCat

/*
 An example paywall that uses the current offering.
 */

struct PaywallView: View {
    
    /// - This binding is passed from ContentView: `paywallPresented`
    @Binding var isPresented: Bool
    
    /// - This can change during the lifetime of the PaywallView (e.g. if poor network conditions mean that loading offerings is slow)
    /// So set this as an observed object to trigger view updates as necessary
    @ObservedObject var userViewModel = UserViewModel.shared
    
    /// - The current offering saved from PurchasesDelegateHandler
    ///  if this is nil, then you might want to show a loading indicator or similar
    private var offering: Offering? {
        userViewModel.offerings?.current
    }

    var body: some View {
        PaywallContent(offering: self.offering, isPresented: self.$isPresented)
    }

}

private struct PaywallContent: View {

    var offering: Offering?
    var isPresented: Binding<Bool>

    /// - State for displaying an overlay view
    @State private var isPurchasing: Bool = false
    @State private var error: NSError?
    @State private var displayError: Bool = false

      var body: some View {
          NavigationView {
              ZStack {
                  
                  //Image("wp")
                   //   .resizable()
                  //    .aspectRatio(contentMode: .fit)
                  
                  VStack (alignment: .leading, spacing: 20) {
                      HStack{
                          Text(  " Premium ")
                              .bold()
                              .font(Font.largeTitle)
                          Image(systemName: "crown.fill")
                              .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                              .foregroundColor(.yellow)
                              .scaleEffect(1.3)
                          
                      }
                           
                           Text(" Go premium for unlimited downloads and full access to our entire wallpaper collection")
                           
                           
                           Spacer()
                           
                      VStack (alignment: .leading,spacing: 10) {
                               
                               HStack {
                                   
                                   Image(systemName: "checkmark.circle.fill")
                                       .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                       .foregroundColor(.white)
                                       
                                   Text("Unlimited access to all wallpapers")
                                       .font(.system(size: 18))
                                       .fontWeight(.semibold)
                               }
                               
                               HStack {
                                   
                                   Image(systemName: "checkmark.circle.fill")
                                       .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                       .foregroundColor(.white)
                                   Text("New exclusive wallpapers weekly")
                                       .font(.system(size: 18))
                                       .fontWeight(.semibold)
                               }
                               
                               HStack {
                                   Image(systemName: "checkmark.circle.fill")
                                       .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                       .foregroundColor(.white)
                                   Text("Unlocked all wallpapers")
                                       .font(.system(size: 18))
                                       .fontWeight(.semibold)
                               }
                          
                          HStack {
                              Image(systemName: "checkmark.circle.fill")
                                  .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                  .foregroundColor(.white)
                              Text("Cancel anytime")
                                  .font(.system(size: 18))
                                  .fontWeight(.semibold)
                          }
                               

                           }
                           Spacer()
                   
 
                      
                      
                      /// - The paywall view list displaying each package
                      List {
                          Section(header: Text("\nWallpaper Premium"), footer: Text(Self.footerText)) {
                              ForEach(offering?.availablePackages ?? []) { package in
                                  PackageCellView(package: package) { (package) in
                                      
                                      /// - Set 'isPurchasing' state to `true`
                                      isPurchasing = true
                                      
                                      /// - Purchase a package
                                      do {
                                          let result = try await Purchases.shared.purchase(package: package)
                                          
                                          /// - Set 'isPurchasing' state to `false`
                                          self.isPurchasing = false
                                          
                                          if !result.userCancelled {
                                              self.isPresented.wrappedValue = false
                                          }
                                      } catch {
                                          self.isPurchasing = false
                                          self.error = error as NSError
                                          self.displayError = true
                                      }
                                  }
                              }
                          }
                      }
                      .listStyle(InsetGroupedListStyle())
                      .navigationBarTitle(" Feng Wallpaper ")
                      .navigationBarTitleDisplayMode(.inline)
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                      .edgesIgnoringSafeArea(.bottom)
                      
                      
                      
                  //    VStack(spacing: 5){
                          HStack{
                              Spacer()
                              Text("Subscrption auto renews every month, cancel anytime.")
                                  .font(.system(size: 12))
                                  .foregroundColor(.white.opacity(0.4))
                              Spacer()
                          }
  
               //       }
                      
                      
                      /// - Display an overlay during a purchase
                      HStack(spacing:30){
                          
                          Link("          Terms of Use (EULA)", destination: URL(string: "https://www.eulatemplate.com/live.php?token=9bhmDEmZlMZb1cGhb8fKhGqV5LV79f4A")!)
                              .foregroundColor(.gray)
                              
                          
                          Link("Privacy Policy", destination: URL(string: "https://www.privacypolicies.com/live/32ac372b-f010-42b6-8855-b863d71f2a80")!)
                              .foregroundColor(.gray)
                          
                      }
                    
                      //ProgressView()
                        //  .foregroundColor(.green)
                  }
                  Rectangle()
                     .foregroundColor(Color.black)
                    .opacity(isPurchasing ? 0.5: 0.0)
                     .edgesIgnoringSafeArea(.all)
              }
          }
          .navigationViewStyle(StackNavigationViewStyle())
          .colorScheme(.dark)
          .alert(
              isPresented: self.$displayError,
              error: self.error,
              actions: { _ in
                  Button(role: .cancel,
                         action: { self.displayError = false },
                         label: { Text("OK") })
              },
              message: { Text($0.recoverySuggestion ?? "Please try again") }
          )
      }
          

      private static let footerText = "By completing this purchase, you agree to our Terms and Conditions. Please read our Terms of Use (EULA) carefully before proceeding with your purchase."

  }
/* The cell view for each package */
private struct PackageCellView: View {

    let package: Package
    let onSelection: (Package) async -> Void
    
    var body: some View {
        Button {
            Task {
                await self.onSelection(self.package)
            }
        } label: {
            self.buttonLabel
        }
        .buttonStyle(.plain)
    }

    private var buttonLabel: some View {
        HStack {
            VStack {
                HStack {
                  //  Text(package.storeProduct.localizedTitle)
                 //   Text("Premium")
                      //  .font(.title3)
                       // .bold()
                    
                    
                   // Spacer()
                }
           
            }
            .padding([.top, .bottom], 8.0)
            
          //  Spacer()
            HStack{
                Text("Premium")
                    .font(.title3)
                    .bold()
                Spacer()
                Text(package.localizedPriceString)
                    .font(.title3)
                    .bold()
                Text("/ month")
                    .font(.title3)
                    .bold()
            }
        }
        .contentShape(Rectangle()) // Make the whole cell tappable
    }

}

extension NSError: LocalizedError {

    public var errorDescription: String? {
        return self.localizedDescription
    }

}

struct PaywallView_Previews: PreviewProvider {

    private static let product1 = TestStoreProduct(
        localizedTitle: "PRO monthly",
        price: 3.99,
        localizedPriceString: "$3.99",
        productIdentifier: "com.revenuecat.product",
        productType: .autoRenewableSubscription,
        localizedDescription: "Description",
        subscriptionGroupIdentifier: "group",
        subscriptionPeriod: .init(value: 1, unit: .month),
        introductoryDiscount: .init(
            identifier: "intro",
            price: 0,
            localizedPriceString: "$0.00",
            paymentMode: .freeTrial,
            subscriptionPeriod: .init(value: 1, unit: .week),
            numberOfPeriods: 1,
            type: .introductory
        ),
        discounts: []
    )
    private static let product2 = TestStoreProduct(
        localizedTitle: "PRO annual",
        price: 34.99,
        localizedPriceString: "$34.99",
        productIdentifier: "com.revenuecat.product",
        productType: .autoRenewableSubscription,
        localizedDescription: "Description",
        subscriptionGroupIdentifier: "group",
        subscriptionPeriod: .init(value: 1, unit: .year),
        introductoryDiscount: nil,
        discounts: []
    )

    private static let offering = Offering(
        identifier: Self.offeringIdentifier,
        serverDescription: "Main offering",
        metadata: [:],
        availablePackages: [
            .init(
                identifier: "monthly",
                packageType: .monthly,
                storeProduct: product1.toStoreProduct(),
                offeringIdentifier: Self.offeringIdentifier
            ),
            .init(
                identifier: "annual",
                packageType: .annual,
                storeProduct: product2.toStoreProduct(),
                offeringIdentifier: Self.offeringIdentifier
            )
        ]
    )

    private static let offeringIdentifier = "offering"

    static var previews: some View {
        PaywallContent(offering: Self.offering, isPresented: .constant(true))
    }

}
