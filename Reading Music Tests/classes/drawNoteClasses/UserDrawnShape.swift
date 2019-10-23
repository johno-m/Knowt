

import Foundation
import UIKit

class UserDrawnShape: CAShapeLayer {
    
    var active = false
    /** UIBezierPath of the shape the user has drawn */
    var userDrawnPath : UIBezierPath!
    /** Count the incorrect points - only calculated at checkDrawing call */
    var incorrectUserPointsCount = 0
    /** CAShapeLayer of the red incorrect line used for debugging */
    var incorrectShape = CAShapeLayer()
    var sS: CGSize!
    
    var pointsToCover = [PointsToCover]()
    var userPoints = [PointsToCover]()
    
    init(isActive: Bool, pointsList: [CGPoint], sS: CGSize){
        
        super.init()
        self.active = isActive
        self.sS = sS
        setPointsToCover(pointsList: pointsList)
        userDrawnPath = UIBezierPath()
        
        self.path = userDrawnPath.cgPath
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.white.cgColor
        self.lineWidth = 12.0
        self.lineCap = "round"
        self.lineJoin = kCALineJoinRound
        
        colorMe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    func setPointsToCover(pointsList: [CGPoint]){
        pointsToCover = [PointsToCover]()
        for point in pointsList {
            pointsToCover.append(PointsToCover(loc: point, cov: false))
        }
        
    }

    struct CheckDrawingReport {
        var success: Bool!
        var dotCoverage: Float!
        var shapeAccuracy: Float!
        var accuracy: Float!
    }
    
    /**
     Returns the breakdown of user accuracy and a success value
    **/
    func checkDrawing(debug: Bool) -> CheckDrawingReport{
        var report = CheckDrawingReport(success: true, dotCoverage: 0.0, shapeAccuracy: 0.0, accuracy: 0.0)
        var uncoveredDots = 0
        incorrectUserPointsCount = 0
        var dA = sS.height * 0.04
        var i = 0
        for coverPoint in pointsToCover {
            var success = false
            for userPoint in userPoints {
                var d = distance(coverPoint.loc, userPoint.loc)
                if d < dA {
                    pointsToCover[i].cov = true
                    success = true
                }
            }
            i += 1
            if success != true {
                uncoveredDots += 1
                if Double(i) > (Double(pointsToCover.count) * 0.75) {
                    print("looks like the stem is wrong")
                }
            }
        }
        
        print("pointsToCover.count = \(pointsToCover.count)")
        print("uncoveredDots = \(uncoveredDots)")
        report.dotCoverage = Float(pointsToCover.count - uncoveredDots) / Float(pointsToCover.count)
        
        // ONLY SHOW THE DOTS IF DEBUGGING
        if debug {
            for point in pointsToCover {
                let dot = CAShapeLayer()
                dot.path = UIBezierPath(ovalIn: CGRect(x: point.loc.x-4, y: point.loc.y-4, width: 8, height: 8)).cgPath
                if point.cov {
                    dot.fillColor = UIColor.green.cgColor
                } else {
                    dot.fillColor = UIColor.red.cgColor
                }
                self.addSublayer(dot)
            }
            
        }
        
        i = 0
        for userPoint in userPoints {
            
            var success = false
            
            for coverPoint in pointsToCover {
                var d = distance(userPoint.loc, coverPoint.loc)
                if d < dA {
                    success = true
                }
            }
            if success {
                userPoints[i].cov = true
            } else {
                print("userPoint = \(userPoint)")
                incorrectUserPointsCount += 1
                userPoints[i].cov = false
                if debug {
                    let dot = CAShapeLayer()
                    dot.path = UIBezierPath(ovalIn: CGRect(x: userPoints[i].loc.x-4, y: userPoints[i].loc.y-4, width: 8, height: 8)).cgPath
                    dot.fillColor = UIColor.red.cgColor
                    self.addSublayer(dot)
                }
            }
            i += 1
        }
        print("userPoints.count = \(userPoints.count)")
        print("incorrectUserPointsCount = \(incorrectUserPointsCount)")
        report.shapeAccuracy = Float(userPoints.count - incorrectUserPointsCount) / Float(userPoints.count)
        
        if uncoveredDots > 1 {
            report.success = false
        }
        
        if incorrectUserPointsCount > 5 {
            print("FAILING FOR THIS REASON")
            report.success = false
            
        }
        
        
        report.accuracy = (report.dotCoverage + report.shapeAccuracy) * 0.5
        
        return report
    }
    
    func showError(){
        
        if incorrectUserPointsCount > 1 {
            print("incorrectUserPointsCount = \(incorrectUserPointsCount)")
            var incorrectPath = UIBezierPath()
            var i = 0
            for point in userPoints {
                if point.cov == false {
                    print("point = \(point)")
                    if i == 0 {
                        incorrectPath.move(to: point.loc)
                    } else {
                        incorrectPath.addLine(to: point.loc)
                    }
                    i += 1
                } else {
                    i = 0
                }
            }
            incorrectShape.path = incorrectPath.cgPath
            print("incorrectShape.path = \(incorrectShape.path)")
            incorrectShape.fillColor = UIColor.clear.cgColor
            incorrectShape.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            incorrectShape.lineWidth = 12.0
            incorrectShape.lineCap = "round"
            incorrectShape.lineJoin = kCALineJoinRound
            incorrectShape.removeFromSuperlayer()
            self.addSublayer(incorrectShape)
        }
        
    }
    
    /**
     CABasicAnimation to morph userDrawnShape into activeShape
     **/
    func incorrectAnimation(correctShape: UIBezierPath){
        
//        showError()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.toValue = correctShape.cgPath
        pathAnimation.duration = 1.3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.repeatCount = 1
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false

        self.add(pathAnimation, forKey: "pathAnimation")

        self.strokeColor = UIColor(red:0.00, green:0.78, blue:1.00, alpha:1.0).cgColor

        let strokeColorAnimation = CABasicAnimation(keyPath: "strokeColor")
        strokeColorAnimation.toValue = UIColor.cyan.cgColor
        strokeColorAnimation.duration = 0.75
        strokeColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        strokeColorAnimation.autoreverses = true
        strokeColorAnimation.repeatCount = .greatestFiniteMagnitude

        self.add(strokeColorAnimation, forKey: "strokeColorAnimation")
    }
    
    func remove(){
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.duration = 0.5
        opacity.fillMode = kCAFillModeForwards
        opacity.isRemovedOnCompletion = false
        self.add(opacity, forKey: "opacity")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
            self.removeFromSuperlayer()
        }
    }
    
    func quickRemove(){
        self.removeAllAnimations()
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.duration = 0.5
        opacity.fillMode = kCAFillModeForwards
        opacity.isRemovedOnCompletion = false
        self.add(opacity, forKey: "opacity")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
            self.removeFromSuperlayer()
            self.opacity = 1
            self.userDrawnPath.removeAllPoints()
            self.path = self.userDrawnPath.cgPath
            self.removeAllAnimations()
        }
        
    }
    
    func colorMe(){
        self.strokeColor = UIColor(red:1, green:1, blue:1, alpha:1.0).cgColor
        
        let strokeColorAnimation = CABasicAnimation(keyPath: "strokeColor")
        strokeColorAnimation.toValue = UIColor(red:0.00, green:1.00, blue:0.52, alpha:1.0).cgColor
        strokeColorAnimation.duration = 2
        strokeColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        strokeColorAnimation.autoreverses = true
        strokeColorAnimation.repeatCount = .greatestFiniteMagnitude
        
        self.add(strokeColorAnimation, forKey: "strokeColorAnimation")
    }
    
}

public func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    let xDist = a.x - b.x
    let yDist = a.y - b.y
    return CGFloat(sqrt(xDist * xDist + yDist * yDist))
}

struct PointsToCover {
    var loc: CGPoint!
    var cov: Bool!
}


class UserDrawnRelic: CAShapeLayer {
    
    init(path: CGPath){
        
        super.init()
        
        self.path = path
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.white.cgColor
        self.lineWidth = 12.0
        self.lineCap = "round"
        self.lineJoin = kCALineJoinRound
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    
    func remove(){
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.duration = 0.5
        opacity.fillMode = kCAFillModeForwards
        opacity.isRemovedOnCompletion = false
        self.add(opacity, forKey: "opacity")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
            self.removeFromSuperlayer()
        }
        
    }
    
    
    
    
}
