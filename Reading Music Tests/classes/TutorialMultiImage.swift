//
//  TutorialMultiImage.swift
//  Reading Music Tests
//
//  Created by John Mckay on 02/11/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import UIKit

class TutorialMultiImage : UIView {
    
    var imgList : [UIImage]!
    var centerPoint : CGPoint!
    var box : CGSize!
    var imagesArray = [UIImageView]()
    var style : String!
    var shown = false
    
    init(imgList:  [UIImage], centerPoint: CGPoint, box: CGSize, style: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: box.width, height: box.height))
        self.center = centerPoint
        self.centerPoint = centerPoint
        self.imgList = imgList
        self.box = box
        self.alpha = 1
        self.style = style
        for img in imgList {
            var newImage = UIImageView(image: img)
            newImage.frame = CGRect(x: 0, y: 0, width: box.width, height: box.height)
            newImage.alpha = 0
            imagesArray.append(newImage)
        }
        for img in imagesArray {
            self.addSubview(img)
        }
    }
    
    func show(){
        shown = true
        if style == "fadeIn" {
            var i:TimeInterval = 0
            for img in imagesArray {
                UIView.animate(withDuration: 1, delay:i, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    img.alpha = 1
                })
                i += 0.3
            }
        }
        if style == "fadeInDrop" {
            var i:TimeInterval = 0
            for img in imagesArray {
                img.center.y -= 200
                UIView.animate(withDuration: 1.2, delay:i, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    img.alpha = 1
                    img.center.y += 200
                })
                i += 0.3
            }
        }
        
        if style == "fadeInRight" {
            var i:TimeInterval = 0
            for img in imagesArray {
                img.center.x -= 200
                UIView.animate(withDuration: 1.2, delay:i, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    img.alpha = 1
                    img.center.x += 200
                })
                i += 0.3
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
