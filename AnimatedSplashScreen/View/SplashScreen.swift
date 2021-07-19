//
//  SplashScreen.swift
//  AnimatedSplashScreen
//
//  Created by Michele Manniello on 19/07/21.
//

import SwiftUI

//Custom View Builder..

struct SplashScreen <Content :View, Title: View, Logo : View , NavButton: View>: View {
    var content: Content
    var titleView : Title
    var logoView : Logo
    var navButton : NavButton
    var imageSze : CGSize
//    Nav Buttons
    init(imageSize : CGSize ,@ViewBuilder content : @escaping()->Content,@ViewBuilder titleView : @escaping()->Title,@ViewBuilder logoView : @escaping()->Logo,@ViewBuilder NavButton : @escaping()->NavButton){
        self.content = content()
        self.titleView = titleView()
        self.logoView = logoView()
        self.navButton = NavButton()
        self.imageSze = imageSize
    }
//    Animation Properties...
    @State var textAnimation = false
    @State var imageAnimation = false
    @State var endAnimation = false
    @State var showNavButtons = false
//    Name Space...
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Color("Purple").ignoresSafeArea()
                //                where not going to do complex reading of top edge..
                //                Simply apply overlay or background it will automaticaly fill edges...
                    .background(Color("Purple"))
                //                i don't know why its giving opacity effct..
                    .overlay(
                        ZStack{
                        titleView
                        //                scaling Text..
                            .scaleEffect(endAnimation ? 0.75: 1 )
                            .offset(y: textAnimation ? -5 :  110)
                        if !endAnimation{
                            logoView
                                .matchedGeometryEffect(id: "LOGO", in: animation)
                                .frame(width: imageSze.width, height: imageSze.height)
                        }
                    }
                    )
                    .overlay(
                        //                moving Right...
                        HStack{
                        //                    Later used for nav Buttons...
                        navButton
                            .opacity(showNavButtons ? 1:0)
                        Spacer()
                        if endAnimation{
                            logoView
                                .matchedGeometryEffect(id: "LOGO", in: animation)
                                .frame(width: 30, height: 30)
                                .padding(.trailing)
                                .offset(y: -5)
                        }
                    }
                            .padding(.horizontal)
                    )
            }
            //            decreasing size when animation ended...
//            Your own Value
            .frame(height: endAnimation ? 60 : nil)
            .zIndex(1)
//            Home View...
            
            content
                .frame(height: endAnimation ? nil: 0)
//            Moving back view...
                .zIndex(0)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
//            starting animation with some delay...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.spring()){
                    textAnimation.toggle()
                }
//                Direct Ending Animation
                withAnimation(Animation.interactiveSpring(response: 0.06, dampingFraction: 1, blendDuration: 1)){
                    endAnimation.toggle()
                }
//                showing after some Deleay...
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                    withAnimation{
                        showNavButtons.toggle()
                    }
                }
            }
        }
    }
}

@available(iOS 15.0, *)
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
