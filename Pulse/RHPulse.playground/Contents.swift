import UIKit
import PlaygroundSupport


let sideLenght = 200
let viewFrame = CGRect(x: 0, y: 0, width: sideLenght, height: sideLenght)

let baseView = UIView(frame: viewFrame)
baseView.backgroundColor = UIColor.white

// Creating our circle path
let circlePath = UIBezierPath(arcCenter: baseView.center,
                              radius: viewFrame.size.width/2,
                              startAngle: CGFloat(0),
                              endAngle:CGFloat(M_PI * 2),
                              clockwise: true)

let lineWidth = CGFloat(3)
let shapeLayer = CAShapeLayer()
shapeLayer.frame = viewFrame
shapeLayer.path = circlePath.cgPath
shapeLayer.fillColor = UIColor.clear.cgColor
shapeLayer.strokeColor = UIColor.blue.cgColor
shapeLayer.lineWidth = lineWidth

// Now the magic 🎩 begins, we create our Replicator 🎉 which will multiply our shapeLayer.
let replicator = CAReplicatorLayer()
replicator.frame = viewFrame
replicator.instanceDelay = 0.007
replicator.instanceCount = 45
replicator.instanceTransform = CATransform3DMakeScale(1, 1, 1.0)

replicator.addSublayer(shapeLayer)

baseView.layer.addSublayer(replicator)

let commonAnimationDuration = 1.5

// Create animation for opacity
let fade = CABasicAnimation(keyPath: "opacity")
fade.fromValue = 0.0
fade.toValue = 0.02
fade.duration = commonAnimationDuration
fade.repeatCount = .infinity
fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

shapeLayer.add(fade, forKey: "shapeLayerOpacity")

// Create animation for scaling our shapeLayer
let scale = CABasicAnimation(keyPath: "transform")
scale.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(0, 0, 1))
scale.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
scale.duration = commonAnimationDuration
scale.repeatCount = .infinity
scale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

shapeLayer.add(scale, forKey: "shapeLayerScale")


PlaygroundPage.current.liveView = baseView