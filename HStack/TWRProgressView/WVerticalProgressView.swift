//
//  WVerticalProgressView.swift
//  HStack
//
//  Created by truwind on 2017. 9. 8..
//  Copyright © 2017년 truwind. All rights reserved.
//

import UIKit

class WVerticalProgressView: UIView {
    var selected: Bool = false
    var isSelected: Bool {
        get
        {
            return self.selected
        }
        set(newValue) {
            self.selected = newValue
            if(!self.selected) {
                self.progress = 0.0
            }
        }
    }
    var progress: CGFloat = 0.0 {
        
        didSet {
            setProgress()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clear;
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setProgress()
    }
    
    func setProgress() {
        var progress = self.progress
        progress = progress > 1.0 ? progress / 100 : progress
        
        //        self.layer.cornerRadius = self.frame.height / 2.0//CGRectGetHeight(self.frame) / 2.0
        self.layer.borderColor = UIColor.gray.cgColor//grayColor().CGColor
        self.layer.borderWidth = 1.0
        
        let margin: CGFloat = 0.0
        var width = (self.frame.width - margin) // * progress
        let height = (self.frame.height - margin ) * progress
        
        let pathRef = UIBezierPath(rect: CGRect(x: margin / 2.0, y: (self.frame.height - margin ), width: width, height: -height))
        UIColor.green.setFill()
        pathRef.fill()
        
        UIColor.clear.setStroke()
        pathRef.stroke()
        
        pathRef.close()
        
        self.setNeedsDisplay()
    }
}
