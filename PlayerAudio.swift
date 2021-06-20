//
//  PlayerAudio.swift
//  KalemProject
//
//  Created by Dzaki Izza on 03/05/21.
//

import SwiftUI
import AVKit

struct PlayerAudio: View {
    @State var audioPlayer : AVAudioPlayer!
    @State var position : Int = 0
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
        VStack {
            
            HStack {
                Text("Music Player").font(.system(size: 45)).fontWeight(.bold)
                    .foregroundColor(.buttonColor)
            }
            HStack {
                Button(action: {
                    self.audioPlayer.play()
                }) {
                    Image(systemName: "play.circle.fil").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.buttonColor)
                    
                    }
                
                Button(action: {
                    self.audioPlayer.play()
                }) {
                    Image(systemName: "pause.circle.fil").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                    
                    }
                }
            }
        }
        .onAppear {
            let urlString = Bundle.main.path(forResource: "Ocean Dream" , ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString!))
        }
    }
}

struct PlayerAudio_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerAudio()
        }
    }
}

