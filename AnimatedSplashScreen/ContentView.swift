//
//  ContentView.swift
//  AnimatedSplashScreen
//
//  Created by Michele Manniello on 19/07/21.
//

import SwiftUI
@available(iOS 15.0, *)
struct ContentView: View {
    var body: some View {
        SplashScreen(imageSize: CGSize(width: 80, height: 80)) {
//            home View..
           Home()
        } titleView: {

            Text("Chatty")
                .font(.system(size: 35).bold())
                .foregroundColor(.white)
            
        } logoView: {
//            make sure to give exact size of logo frame here..
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        } NavButton: {
//            Your nav bar butons...
            Button {
                
            } label: {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }

        }

    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
