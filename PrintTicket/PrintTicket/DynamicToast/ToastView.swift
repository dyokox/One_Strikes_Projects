import SwiftUI

extension View {
    @ViewBuilder
    func dynamicIslandToast(isPresented: Binding<Bool>) -> some View {
        self
            .modifier(
                DynamicIslandToastViewModifier(isPresented: isPresented)
            )
    }
}

struct DynamicIslandToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var overlayWindow: PassThroughWindow?
    @State private var overlayController: CustomHostingController?
    func body(content: Content) -> some View {
        content
            .background(WindowExtractor { mainWindow in
                createOverlayWindow(mainWindow)
            })
            .onChange(of: isPresented) { oldValue, newValue in
                guard let overlayWindow else { return }
                overlayWindow.isPresented = newValue
                overlayController?.isStatusBarHidden = newValue
            }
            .onChange(of: overlayWindow?.isPresented) { oldValue, newValue in
                if let newValue, newValue != isPresented {
                    isPresented = false
                }
            }
    }
    
    private func createOverlayWindow(_ mainWindow: UIWindow) {
        guard let windowScene = mainWindow.windowScene else {return}
        
        if let window = windowScene.windows.first(where: {$0.tag == 1009}) as? PassThroughWindow {
            print("Using already existing window")
            self.overlayWindow = window
        } else {
            let overlayWindow = PassThroughWindow(windowScene: windowScene)
            overlayWindow.backgroundColor = .clear
            overlayWindow.isHidden = false
            overlayWindow.isUserInteractionEnabled = true
            overlayWindow.tag = 1009
            createRootController(overlayWindow)
            
            
            self.overlayWindow = overlayWindow
        }
    }
    
    private func createRootController(_ window: PassThroughWindow) {
        let hostingController = CustomHostingController(
            rootView: ToastView(window: window)
        )
        
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        self.overlayController = hostingController
    }
}

struct ToastView: View {
    var window: PassThroughWindow
    
    @State private var printed: CGFloat = 0
    
    private let receiptSize = CGSize(width: 265, height: 400)
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            let haveDynamicIsland = safeArea.top >= 59
            let slotHeight: CGFloat = 36
            let slotY: CGFloat = haveDynamicIsland ? 11 + max(safeArea.top - 59, 0) : safeArea.top + 4
            
            ZStack(alignment: .top) {
                Receipt()
                    .frame(width: receiptSize.width, height: receiptSize.height)
                    .offset(y: -receiptSize.height * (1 - printed))
                    .frame(width: receiptSize.width, height: receiptSize.height, alignment: .top)
                    .clipped()
                    .shadow(color: .black.opacity(0.25), radius: 10, y: 6)
                    .contentShape(.rect)
                    .gesture(
                        DragGesture().onEnded { value in
                            if value.translation.height < 0 {
                                window.isPresented = false
                            }
                        }
                    )
                    .padding(.top, slotY + slotHeight / 2)
                
                Capsule()
                    .fill(.black)
                    .frame(width: isExpanded ? receiptSize.width + 20 : 94, height: slotHeight)
                    .opacity(haveDynamicIsland || isExpanded ? 1 : 0)
                    .padding(.top, slotY)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .animation(.bouncy(duration: 0.3, extraBounce: 0), value: isExpanded)
        }
        .onChange(of: isExpanded) { _, newValue in
            if newValue {
                printReceipt()
            } else {
                withAnimation(.easeIn(duration: 0.35)) { printed = 0 }
            }
        }
    }
    private func printReceipt() {
        Task { @MainActor in
            let steps = 8
            for step in 1...steps {
                guard isExpanded else { return }
                withAnimation(.easeOut(duration: 2)) { printed = 1 }
                try? await Task.sleep(for: .seconds(0.24))
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { window.isPresented = false }
    }
    
    var isExpanded: Bool {
        window.isPresented
    }
}

#Preview {
    ContentView()
}
