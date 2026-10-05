import SwiftUI

@Observable
class PassThroughWindow: UIWindow {
    var isPresented: Bool = false
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view else {
            return nil
        }
        
        if #available(iOS 27, *) {
            if rootView.layer.hitTest(point)?.name == nil {
                return rootView
            }
            return nil
            
        } else {
            if #unavailable (iOS 18) {
                return hitView == rootView ? nil : hitView
            } else {
                for subview in rootView.subviews.reversed() {
                    let pointInSubView = subview.convert(point, from: rootView)
                    if subview.hitTest(pointInSubView, with: event) != nil {
                        return hitView
                    }
                }
                
                return nil
            }
        }
    }
}
