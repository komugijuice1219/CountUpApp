//
//  ContentView.swift
//  countup
//
//  Created by たお1219 on 2024/11/13.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @AppStorage("total") private var total = 0
    
    @State private var rotationAngle = 0.0
    @State private var audioPlayer: AVAudioPlayer?
    @State private var backgroundAudioPlayer: AVAudioPlayer? // 背景音乐播放器
    @State private var soundEffectAudioPlayer: AVAudioPlayer? // 按钮音效播放器
    
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack {
                
                if total < 0 {
                    
                    Image("default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                }else{
                    HStack{
                        ZStack {
                            Image("\(total/100)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120,height: 120)
                                .rotation3DEffect(
                                    .degrees(rotationAngle),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .opacity(rotationAngle.truncatingRemainder(dividingBy: 360) == 0 ? 1 : 0)
                            
                            Image("\(total / 100)") // 背面图片
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .rotation3DEffect(.degrees(rotationAngle + 180), axis: (x: 0, y: 1, z: 0))
                                .opacity(rotationAngle.truncatingRemainder(dividingBy: 360) == 0 ? 0 : 1)
                        }
                        
                        ZStack {
                            Image("\((total/10)%10)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120,height: 120)
                                .rotation3DEffect(
                                    .degrees(rotationAngle),
                                    axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                    
                                )
                                .opacity(rotationAngle.truncatingRemainder(dividingBy: 360) == 0 ? 1 : 0)
                            
                            Image("\((total / 10) % 10)") // 背面图片
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .rotation3DEffect(.degrees(rotationAngle + 180), axis: (x: 0, y: 1, z: 0))
                                .opacity(rotationAngle.truncatingRemainder(dividingBy: 360) == 0 ? 0 : 1)
                        }
                        
                        ZStack {
                            Image("\(total%10)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120,height: 120)
                                .rotation3DEffect(
                                    .degrees(rotationAngle),
                                    axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                )
                                .opacity(rotationAngle.truncatingRemainder(dividingBy: 360) == 0 ? 1 : 0)
                            
                            Image("\(total % 10)") // 背面图片
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .rotation3DEffect(.degrees(rotationAngle + 180), axis: (x: 0, y: 1, z: 0))
                                .opacity(rotationAngle.truncatingRemainder(dividingBy: 360) == 0 ? 0 : 1)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 40)
                HStack{
                    
                    Button(action: {
                        playSound(named:"click")
                        withAnimation {
                            
                            rotationAngle += 180
                            total += 1
                        }
                    }){
                        Image(systemName: "plus")
                            .font(.system(size:45))
                            .foregroundColor(.gray)
                    }
                    .disabled(total < 0)
                    
                    Spacer()
                        .frame(width: 30)
                    
                    
                    Button(action: {
                        playSound(named:"click")
                        withAnimation {
                            rotationAngle -= 180
                            total -= 1
                        }
                    }){
                        Image(systemName: "minus")
                            .font(.system(size:45))
                            .foregroundColor(.gray)
                    }
                    .disabled(total < 0)
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Button {
                        playSound(named:"neko1")
                        withAnimation {
                            total = 0
                        }
                    } label: {
                        Image(systemName: "arrow.circlepath")
                            .font(.system(size: 38))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
                   playBackgroundMusic() // 视图加载时播放背景音乐
               }
    }
    
    func playBackgroundMusic() {
           guard let soundURL = Bundle.main.url(forResource: "bgm", withExtension: "mp3") else { return }
           
           do {
               backgroundAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
               backgroundAudioPlayer?.numberOfLoops = -1 // 循环播放
               backgroundAudioPlayer?.play()

           } catch {
               print("无法播放背景音乐: \(error.localizedDescription)")
           }
       }
    
    func playSound(named soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            soundEffectAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                       soundEffectAudioPlayer?.play()
        } catch {
            print("无法播放音效: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
