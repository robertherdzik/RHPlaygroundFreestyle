import UIKit
import PlaygroundSupport

let sideLenght = 200
let viewFrame = CGRect(x: 0, y: 0, width: sideLenght, height: sideLenght)

let baseView = UIView(frame: viewFrame)
baseView.backgroundColor = UIColor.gray

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
shapeLayer.strokeColor = UIColor.cyan.cgColor
shapeLayer.lineWidth = lineWidth

// Now the magic 🎩 begins, we create our Replicator 🎉 which will multiply our shapeLayer.
let replicator = CAReplicatorLayer()
replicator.frame = viewFrame
replicator.instanceDelay = 0.05
replicator.instanceCount = 30
replicator.instanceTransform = CATransform3DMakeScale(1, 1, 1)


replicator.addSublayer(shapeLayer)

baseView.layer.addSublayer(replicator)

let fade = CABasicAnimation(keyPath: "opacity")
fade.fromValue = 0.05
fade.toValue = 0.3
fade.duration = 1.5
fade.beginTime = CACurrentMediaTime()
fade.repeatCount = .infinity
fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

shapeLayer.add(fade, forKey: "shapeLayerOpacity")

let scale = CABasicAnimation(keyPath: "transform")
scale.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(0, 0, 1))
scale.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
scale.duration = 1.5
scale.repeatCount = .infinity
scale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

shapeLayer.add(scale, forKey: "shapeLayerScale")


PlaygroundPage.current.liveView = baseView
