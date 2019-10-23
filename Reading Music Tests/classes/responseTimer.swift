//
//  responseTimer.swift
//  Reading Music Tests
//
//  Created by John Mckay on 28/01/2019.
//  Copyright © 2019 John Mckay. All rights reserved.
//

import Foundation
import UIKit

class ResponseTimer {
    var timer = Timer()
    var count = Double()
    
    init() {
        self.count = 0
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.addCount), userInfo: nil, repeats: true)
    }
    
    @objc func addCount() {
        self.count += 0.1
        
    }
    
    func stop() {
        self.timer.invalidate()
        print("Count reached \(count) seconds")
        self.count = 0
    }
    
    deinit {
        self.timer.invalidate()
        print("Count reached \(count) seconds")
        self.count = 0
    }
}
