import UIKit
import PlaygroundSupport

let viewFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
let view = UIView(frame: viewFrame)
view.backgroundColor = .lightGray

let animation = CABasicAnimation(keyPath: "position.x")
animation.duration = 1
animation.fromValue = -view.bounds.width
animation.toValue = 2*view.bounds.width
animation.isRemovedOnCompletion = false
animation.repeatCount = Float.infinity
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

let gradient = CAGradientLayer()
gradient.colors = [
    UIColor.lightGray.cgColor,
    UIColor.white.cgColor,
    UIColor.white.cgColor,
    UIColor.lightGray.cgColor
]
gradient.frame = CGRect(x: 0,
                        y: 0,
                        width: 2*viewFrame.width,
                        height: 2*viewFrame.height)

gradient.startPoint = CGPoint(x:0.2, y:0.3)
gradient.endPoint = CGPoint(x:1, y:1)

gradient.opacity = 0.4
gradient.locations = [0, 0.2, 0.22, 0.4]

gradient.add(animation, forKey: "gradient")


view.layer.addSublayer(gradient)

PlaygroundPage.current.liveView = view
