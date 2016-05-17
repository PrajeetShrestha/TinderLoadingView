//
//  TinderLoadingView.swift
//  Test
//
//  Created by Prajeet Shrestha on 5/17/16.
//  Copyright © 2016 com.javra.test. All rights reserved.
//

import UIKit
class RoundView:UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
 
        
    }
}

//-------------------------------------------------------------------------------------------
//MARK: - Configuration
//-------------------------------------------------------------------------------------------

let transformationScale:CGFloat = 100
let expandingViewColor = UIColor(red: 63/255, green: 152/255, blue: 250/255, alpha: 0.7)
let waveFrequency = 3
let animationDuration:Double = 4
let expandingViewWidth:Double = 3
let expandingViewHeight:Double = 3

class TinderLoadingView: UIView {
    let transformation = CGAffineTransformMakeScale(transformationScale, transformationScale)
    var views:[UIView] = [UIView]()
    
    
    //-------------------------------------------------------------------------------------------
    //MARK: - Initialization
    //-------------------------------------------------------------------------------------------
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.load()
        print(self.subviews)
        
    }
    
    
    func load() {
        for _ in 0...waveFrequency {
            views.append( self.addExpandingView())
        }
       let centerView = self.addExpandingView(20)
        centerView.backgroundColor = UIColor.blackColor()   
        
        
    }
    
    
    func start() {
        let delayScale:Double = Double(animationDuration)   / Double(views.count)
        var count:Double = 0
        for view in views {
            self.animate(view, delay: NSTimeInterval(count * delayScale))
            print( NSTimeInterval(count * delayScale))
            count += 1

        }
    }
    
}

//-------------------------------------------------------------------------------------------
//MARK: - Animation
//-------------------------------------------------------------------------------------------
extension TinderLoadingView {
    func animate(view:UIView , delay:NSTimeInterval) {
        UIView.animateWithDuration(Double(animationDuration), delay: delay, options: [.Repeat, .CurveLinear], animations: {
            () -> Void in
            view.transform = self.transformation
            view.alpha = 0
            }, completion:nil)
    }
}
//-------------------------------------------------------------------------------------------
//MARK: - LayoutSetup
//-------------------------------------------------------------------------------------------
extension TinderLoadingView  {
    
    
    func addExpandingView(width:Double = expandingViewHeight) -> UIView {
        let roundView = UIView(frame: CGRectMake(0,0,20,20))
        roundView.layer.cornerRadius = CGFloat(expandingViewWidth / Double(2.0))
        roundView.clipsToBounds = true
        roundView.backgroundColor = expandingViewColor
        self.addSubview(roundView)
        roundView.translatesAutoresizingMaskIntoConstraints = false
        self.setWidthAndHeight(roundView, width: width)
        self.centerHV(roundView)
        return roundView
    }
    
    func setWidthAndHeight(view:UIView, width:Double = expandingViewHeight) {
        let viewDic = ["View":view]
        let viewMetrics =
        [
            "width" : width,
            "height": width
        ]
        let horizontalCons = NSLayoutConstraint.constraintsWithVisualFormat("H:[View(width)]", options:[], metrics: viewMetrics, views: viewDic);
        let veritcleCons = NSLayoutConstraint.constraintsWithVisualFormat("V:[View(height)]", options:[], metrics: viewMetrics, views: viewDic);
        view.superview?.addConstraints(horizontalCons)
        view.superview?.addConstraints(veritcleCons)
    }
    
    func centerHV(view:UIView) {
        let centerVertically =  NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview, attribute: .CenterY, multiplier: 1, constant: 0)
        let centerHorizontally =  NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem:view.superview , attribute: .CenterX, multiplier: 1, constant: 0)
        view.superview?.addConstraints([centerVertically,centerHorizontally])
    }
}