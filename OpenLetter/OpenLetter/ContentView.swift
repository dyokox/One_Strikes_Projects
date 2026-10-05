import SwiftUI

struct ContentView: View {
    @State private var isOpen = false
    @State private var flapOnTop = true
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: 260, height: 180)
                    .shadow(radius: 2)
                    .overlay(
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Dear reader, \nBurn all the files, desert all your past lifes \nAnd if you don't recognize yourself \nThat means you did it right")
                                .font(.custom("Reenie Beanie", size: 16))
                                .padding(5)
                            
                            Text("Taylor Swift")
                                .font(.custom("Reenie Beanie", size: 16))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(5)
                        }
                            .padding()
                    )
                    .offset(y: isOpen ? -200 : 0)
                    .animation(
                        .spring(response: 0.6, dampingFraction: 0.8)
                        .delay(isOpen ? 0.3 : 0),
                        value: isOpen
                    )
                    .zIndex(1)
                
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.orange.opacity(0.9))
                    .frame(width: 280, height: 205)
                    .zIndex(0)
                
                EnvelopeFrontShape()
                    .fill(Color.orange)
                    .frame(width: 280, height: 200)
                    .zIndex(2)
                
                EnvelopeFlapShape()
                    .fill(Color.orange)
                    .frame(width: 280, height: 120)
                    .shadow(color: .black.opacity(0.3), radius: 4, y: 5)
                    .rotation3DEffect(
                        .degrees(isOpen ? -180 : 0),
                        axis: (x: 1.0, y: 0.0, z: 0.0),
                        anchor: .top,
                        perspective: 0.6
                    )
                    .offset(y: -41)
                    .animation(
                        .spring(response: 0.6, dampingFraction: 0.6)
                        .delay(isOpen ? 0 : 0.8),
                        value: isOpen
                    )
                    .zIndex(flapOnTop ? 3 : 0)
                
            }
            .frame(width: 290, height: 200)
            
            Button(isOpen ? "Close Envelope" : "Open Envelope") {
                isOpen.toggle()
                
                if isOpen {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        if isOpen { flapOnTop = false }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                        if !isOpen { flapOnTop = true }
                    }
                }
            }
            .font(.custom("Reenie Beanie", size: 24))
            .buttonStyle(.borderedProminent)
            .tint(.black)
            .padding()
        }
        .shadow(color: .black.opacity(0.1), radius: 4, y: 5)
        
    }
}
struct EnvelopeFrontShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + 20))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct EnvelopeFlapShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.05).ignoresSafeArea()
        ContentView()
    }
}
