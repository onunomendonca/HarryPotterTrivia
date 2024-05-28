//
//  ContentView.swift
//  HarryPotterTrivia
//
//  Created by Nuno Mendonça on 24/05/2024.
//

import SwiftUI
import AVKit //Audio import

struct ContentView: View {

    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewsIn = false

    var body: some View {
        //Allow us to have the size of our view.
        GeometryReader { geo in

            ZStack {

                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .offset(x: self.moveBackgroundImage ? geo.size.width/1.1 : -geo.size.width/1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            self.moveBackgroundImage.toggle()
                        }
                    }

                VStack {
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)

                                Text("Harry Potter")
                                    .font(.custom(Constants.hpFont, size: 70))
                                    .padding(.bottom, -50)

                                Text("Trivia")
                                    .font(.custom(Constants.hpFont, size: 60))
                            }
                            .padding(.top, 70)
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(.easeOut(duration: 0.7).delay(2), value: self.animateViewsIn)

                    Spacer()

                    VStack {
                        if animateViewsIn {
                            VStack {

                                Text("Recent Scores")
                                    .font(.title2)

                                Text("33")
                                Text("27")
                                Text("15")
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.7))
                            .cornerRadius(15)
                            .transition(.opacity)
                        }
                    }
                    .animation(.linear(duration: 1).delay(4), value: self.animateViewsIn)

                    Spacer()

                    HStack {
                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    //open game instructions screen
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: -geo.size.width/4))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2.7), value: self.animateViewsIn)


                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    //start a new game
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(.brown)
                                        .cornerRadius(7)
                                        .shadow(radius: 5)
                                }
                                .scaleEffect(self.scalePlayButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height/3))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: self.animateViewsIn)

                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    //show setting screen
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: geo.size.width/4))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2.7), value: self.animateViewsIn)

                        Spacer()
                    }
                    .frame(width: geo.size.width)

                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            //self.playAudio()
            self.animateViewsIn = true
        }
    }

    private func playAudio() {

        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        self.audioPlayer.numberOfLoops = -1
        self.audioPlayer.play()
    }
}

#Preview {
    ContentView()
}
