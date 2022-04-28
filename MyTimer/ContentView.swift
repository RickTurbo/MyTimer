//
//  ContentView.swift
//  MyTimer
//
//  Created by 児島　陸斗 on 2022/04/27.
//

import SwiftUI

struct ContentView: View {
    @State var timerHandler : Timer?
    @State var count = 0
    @AppStorage("timer_value") var timerValue = 10

    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)

                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)

                    HStack {
                        Button(action: {
                            startTimer()
                        })  {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                        }

                        Button(action: {
                            if let unwrapedTimerHandler = timerHandler {
                                if unwrapedTimerHandler.isValid == true {
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        })  {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                        }
                    }
                }
            }

            .onAppear {
                count = 0
            }

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Text("秒数設定")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func countDownTimer() {
        count += 1
        if timerValue - count <= 0 {
            timerHandler?.invalidate()
        }
    }

    func startTimer() {
        if let unwrapedTimerHandler = timerHandler {
            if unwrapedTimerHandler.isValid == true {
                return
            }
        }

        if timerValue - count <= 0 {
            count = 0
        }

        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            countDownTimer()
        }
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
