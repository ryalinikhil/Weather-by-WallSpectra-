//
//  meteorView.swift
//  Weather by WallSpectra
//
//  Created by Sameer Nikhil on 29/08/23.
//

import SwiftUI


struct Meteor: Identifiable {
    var id = UUID()
    var offset: CGSize
    var angle: Double
}

struct MeteorView: View {
    @State private var meteors: [Meteor] = []
    
    let meteorCount = 80 // Adjust this to control the number of meteors
    
    var body: some View {
        ZStack {
            
            //Color.black.edgesIgnoringSafeArea(.all)
            
            ForEach(meteors) { meteor in
                MeteorShape()
                    .foregroundColor(.white)
                    .frame(width: 2, height: 4) // Adjust the height as needed
                    .offset(meteor.offset)
                    .rotationEffect(.degrees(meteor.angle))
            }
        }
        .onAppear {
            setupMeteors()
            startAnimation()
        }
    }

    private func setupMeteors() {
        let safeAreaTop = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        meteors = (0..<meteorCount).map { _ in
            Meteor(offset: CGSize(width: CGFloat.random(in: 0...UIScreen.main.bounds.width), height: -safeAreaTop),
                   angle: Double.random(in: 30...60))
        }
    }
    
    private func startAnimation() {
        for index in 0..<meteors.count {
            animateMeteor(at: index)
        }
    }
    
    private func animateMeteor(at index: Int) {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
            meteors[index].offset.height = UIScreen.main.bounds.height + 20 // Adjust the height value
        }
    }
}

struct MeteorShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let startX = rect.origin.x
            let startY = rect.origin.y
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: startX + rect.width, y: startY))
            path.addLine(to: CGPoint(x: startX + rect.width / 2, y: startY + rect.height))
            path.closeSubpath()
        }
    }
}

struct ContentView3: View {
    var body: some View {
        MeteorView()
    }
}

struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}
