import SwiftUI

struct ContentView: View {
    @State private var showToast: Bool = false
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                showToast = true
            } label: {
                Image(systemName: "printer")
                Text("Print receipt")
                
            }
            .dynamicIslandToast(isPresented: $showToast)
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .frame(width: 160, height: 50, alignment: .bottom)
            )
        }
    }
}

#Preview {
    ContentView()
}
