import UIKit
import PlaygroundSupport

let viewFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
let view = UIView(frame: viewFrame)
view.backgroundColor = .white

let animation = CABasicAnimation(keyPath: "position.x")
animation.duration = 1
animation.fromValue = -view.bounds.width
animation.toValue = 2*view.bounds.width
animation.isRemovedOnCompletion = false
animation.repeatCount = Float.infinity
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

func addGradient(view: UIView) -> CAGradientLayer {
    let gradient = CAGradientLayer()
    gradient.colors = [
        UIColor.lightGray.cgColor,
        UIColor.white.cgColor,
        UIColor.white.cgColor,
        UIColor.lightGray.cgColor
    ]
    gradient.frame = CGRect(x: 0,
                            y: 0,
                            width: 2*view.bounds.width,
                            height: 2*view.bounds.height)
    
    gradient.startPoint = CGPoint(x:0.2, y:0.3)
    gradient.endPoint = CGPoint(x:1, y:0.9)
    
    gradient.opacity = 0.4
    gradient.locations = [0, 0.2, 0.22, 0.4]
    
    gradient.add(animation, forKey: "gradient")
    
    return gradient
}


var label = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 70))
label.backgroundColor = UIColor.lightGray

var image = UIView(frame: CGRect(x: 0, y: 80, width: 80, height: 70))
image.backgroundColor = UIColor.lightGray

[label, image].forEach {
    view.addSubview($0)
}

[label, image].forEach {
    let gradient = addGradient(view: label)
    $0.layer.addSublayer(gradient)
    $0.layer.masksToBounds = true
}

PlaygroundPage.current.liveView = view
