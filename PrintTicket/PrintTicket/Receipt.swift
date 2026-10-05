import SwiftUI

struct Receipt: View {
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "laurel.trailing")
                    .font(.system(size: 70))
                    .rotationEffect(.degrees(90))
                Text("GRAUS COFFEE")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .monospaced()
                
                Text("SPECIAL COFFEE FOR SPECIAL DAYS")
                    .font(.system(size: 10))
                    .fontDesign(.monospaced)
                    .italic()
            }
            .padding(5)
            
            DashedLine()
                .padding(.bottom, 5)
            
            HStack {
                Text("RECEIPT 0013")
                Spacer()
                Text("13:13")
            }
            .font(.system(size: 10))
            .fontDesign(.monospaced)
            .foregroundStyle(.secondary)
            .padding(.bottom, 5)
            
            HStack {
                Text("Hot Chocolate")
                Spacer()
                Text("£3.50")
            }
            .font(.system(size: 15))
            .fontDesign(.monospaced)
            .foregroundStyle(.black.opacity(0.70))
            .fontWeight(.semibold)
            .padding(.bottom, 5)
            
            HStack {
                Text("Croissant")
                Spacer()
                Text("£2.00")
            }
            .font(.system(size: 15))
            .fontDesign(.monospaced)
            .foregroundStyle(.black.opacity(0.70))
            .fontWeight(.semibold)
            .padding(.bottom, 5)

            DashedLine()
                .padding(.bottom, 5)
            
            
            HStack {
                Text("TOTAL")
                Spacer()
                Text("£5.50")
            }
            .font(.system(size: 20))
            .fontDesign(.monospaced)
            .fontWeight(.heavy)
            .padding(.bottom, 5)
            
            HStack(spacing: -6) {
                ForEach(0..<6) {line in
                    Image(systemName: "barcode")
                        .font(.system(size: 35))
                }
            }
            
            Text("PAID · THANK YOU!")
                .font(.system(size: 12))
                .fontDesign(.monospaced)
                .foregroundStyle(.secondary)
                .padding(10)

            
        }
        .padding(20)
        .frame(width: 265, height: 400)
        .background(
            ReceiptShape()
                .fill(.white)
        )

        
    }
}

struct DashedLine: View {
    var body: some View {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: 10_000, y: 0))
        }
        .stroke(.secondary, style: StrokeStyle(lineWidth: 1.5, dash: [4, 4]))
        .frame(height: 1.5)
        .clipped()
    }
}

struct ReceiptShape: Shape {
    var toothWidth: CGFloat = 12
    var toothHeight: CGFloat = 8

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baseY = rect.maxY - toothHeight

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: baseY))

        let count = max(1, Int((rect.width / toothWidth).rounded()))
        let step = rect.width / CGFloat(count)

        for i in 0..<count {
            let xStart = rect.maxX - CGFloat(i) * step
            path.addLine(to: CGPoint(x: xStart - step / 2, y: rect.maxY))
            path.addLine(to: CGPoint(x: xStart - step, y: baseY))
        }

        path.closeSubpath()
        return path
    }
}

#Preview {
    Receipt()
}
