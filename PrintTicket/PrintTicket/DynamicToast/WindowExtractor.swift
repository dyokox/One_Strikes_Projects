import SwiftUI

struct WindowExtractor: UIViewRepresentable {
    var result: (UIWindow) -> ()
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let window = view.window {
                result(window)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
