//
//  BallScaleMultiple.swift
//  LoaderUI
//
//  Created by 牧野壽永 on 2023/03/03.
//

import SwiftUI

struct BallScaleMultiple: View {
    @State private var isAnimating = false
    @State private var scale: [Double] = [0, 0, 0]
    @State private var opacity: [Double] = [0, 0, 0]
    private let dulation: Double
    private let beginTimes = [0, 0.2, 0.4]
    
    init() {
        self.dulation = 1.0
    }
    init(dulation: Double) {
        self.dulation = dulation
    }
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<3) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .scaleEffect(scale[index])
                        .opacity(opacity[index])
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {
                    isAnimating = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + beginTimes[index]) {
                        animation(index: index)
                    }
                }
                .onDisappear {
                    isAnimating = false
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    func animation(index: Int) {
            withAnimation(Animation
                .linear(duration: dulation)
            ) {
                self.scale[index] = 1.0
            }
            withAnimation(Animation
                .linear(duration: 0.05 * dulation)
            ) {
                self.opacity[index] = 1.0
            }
            withAnimation(Animation
                .linear(duration: 0.95 * dulation)
                .delay(0.05 * dulation)
            ) {
                self.opacity[index] = 0.0
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 * dulation) {
            if isAnimating {
                self.scale[index] = 0
                self.opacity[index] = 0
                animation(index: index)
            }
        }
    }
}

struct BallScaleMultiple_Previews: PreviewProvider {
    static var previews: some View {
        BallScaleMultiple()
    }
}
