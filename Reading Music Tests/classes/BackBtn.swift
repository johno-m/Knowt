//
//  BackBtn.swift
//  Reading Music Tests
//
//  Created by John Mckay on 25/10/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import UIKit

class BackBtn: UIButton {

    required init(color: UIColor) {
        // set myValue before super.init is called
        let sS = UIScreen.main.bounds.size
        let newFrame = CGRect(x: 20, y: 30, width: sS.width * 0.035, height: sS.width * 0.035)
        super.init(frame: newFrame)
        
       
       let imageSrc = UIImage(named: "backBtn")
       let tintedImage = imageSrc?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
       self.setImage(tintedImage, for: .normal)
       self.tintColor = color
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class NextBtn: UIButton {

    required init(color: UIColor) {
        // set myValue before super.init is called
        let sS = UIScreen.main.bounds.size
        let newFrame = CGRect(x: sS.width - ((sS.width*0.08) * 1.5), y: sS.height - ((sS.width*0.08) * 1.5), width: sS.width*0.08, height: sS.width*0.08)
        super.init(frame: newFrame)
        
       
       let imageSrc = UIImage(named: "nextBtn")
       let tintedImage = imageSrc?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
       self.setImage(tintedImage, for: .normal)
       self.tintColor = color
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
