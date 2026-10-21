//
//  Deep Breath.swift
//  MyApp
//
//  Created by Raneem Marzouq Albogami on 09/05/1448 AH.
//

import SwiftUI

struct Deep_Breath: View {
    @Environment(\.dismiss) private var dismiss

        // الألوان
        let bgColor = Color(red: 0.965, green: 0.937, blue: 0.910)
        let cardColor = Color(red: 0.945, green: 0.925, blue: 0.885)
        let pillColor = Color(red: 0.90, green: 0.88, blue: 0.86)

        // حالة التنفس والوقت
        @State private var isInhaling = true
        @State private var remainingSeconds = 300   // 5:00
        @State private var timer: Timer?
    var body: some View {
        ZStack {
                    bgColor.ignoresSafeArea()

                    VStack(spacing: 0) {

                        // زر Skip
                        HStack {
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Text("Skip")
                                    .font(.system(size: 22))
                                    .underline()
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 30)
                        // العنوان
                                       Text("Deep Breath")
                                           .font(.system(size: 48, weight: .bold))
                                           .foregroundColor(.black)
                                           .padding(.top, 10)
                        // بطاقة الوقت
                                 HStack {
                                     Text("Time")
                                         .font(.system(size: 16))
                                         .foregroundColor(.black)
                                     Spacer()
                                     Text(timeString)
                                         .font(.system(size: 17, weight: .regular, design: .monospaced))
                                         .foregroundColor(.black)
                                         .padding(.horizontal, 12)
                                         .padding(.vertical, 6)
                                         .background(pillColor)
                                         .clipShape(Capsule())
                                 }
                                 .padding(.horizontal, 22)
                                 .frame(width: 520, height: 70)
                                 .background(cardColor)
                                 .clipShape(RoundedRectangle(cornerRadius: 14))
                                 .shadow(color: .black.opacity(0.15), radius: 14, x: 0, y: 10)
                                 .padding(.top, 50)

                                 Spacer()

                                 // صورة النجمة (أضفها في Assets باسم "StarMeditate")
                        Image(.star)
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width: 520)
                                     .scaleEffect(isInhaling ? 1.0 : 0.92)
                                     .animation(.easeInOut(duration: 4), value: isInhaling)

                                 Spacer()

                                 // موجة التنفس + النصوص
                                 VStack(spacing: 6) {
                                     BreathWave()
                                         .stroke(Color.black, lineWidth: 1)
                                         .frame(width: 420, height: 70)

                                     HStack {
                                         Text("inhale")
                                         Spacer()
                                         Text("Exhale")
                                     }
                                     .font(.system(size: 15, weight: .bold))
                                     .foregroundColor(.black)
                                     .frame(width: 440)
                                 }
                                 .padding(.bottom, 80)
                             }
                         }
                         .onAppear { startSession() }
                         .onDisappear { timer?.invalidate() }
                     }

                     // MARK: - Helpers

                     private var timeString: String {
                         let m = remainingSeconds / 60
                         let s = remainingSeconds % 60
                         return String(format: "%d:%02d", m, s)
                     }

                     private func startSession() {
                         isInhaling = false   // يبدأ الأنيميشن
                         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
                             if remainingSeconds > 0 {
                                 remainingSeconds -= 1
                                 if remainingSeconds % 4 == 0 {
                                     isInhaling.toggle()
                                 }
                             } else {
                                 t.invalidate()
                                 dismiss()
                             }
                         }
                     }
                 }

                 // شكل الموجة (ثلاث خطوط متموجة)
                 struct BreathWave: Shape {
                     func path(in rect: CGRect) -> Path {
                         var path = Path()
                         let offsets: [CGFloat] = [0, 0.18, 0.36]

                         for o in offsets {
                             let startY = rect.height * (0.55 + o * 0.6)
                             path.move(to: CGPoint(x: 0, y: startY))
                             path.addCurve(
                                 to: CGPoint(x: rect.width * 0.5, y: rect.height * (0.05 + o * 0.5)),
                                 control1: CGPoint(x: rect.width * 0.2, y: startY),
                                 control2: CGPoint(x: rect.width * 0.3, y: rect.height * (0.05 + o * 0.5))
                             )
                             path.addCurve(
                                 to: CGPoint(x: rect.width, y: rect.height * (0.6 + o * 0.5)),
                                 control1: CGPoint(x: rect.width * 0.7, y: rect.height * (0.05 + o * 0.5)),
                                 control2: CGPoint(x: rect.width * 0.85, y: rect.height * (0.6 + o * 0.5))
                             )
                         }
                         return path
                    }
}

#Preview {
    Deep_Breath()
}
