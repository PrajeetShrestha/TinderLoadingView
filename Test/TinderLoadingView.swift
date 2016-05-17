//
//  TinderLoadingView.swift
//  Test
//
//  Created by Prajeet Shrestha on 5/17/16.
//  Copyright © 2016 com.javra.test. All rights reserved.
//

import UIKit
class TinderLoadingView: UIView {
    
    //-------------------------------------------------------------------------------------------
    // transformationScale determines how big will the wave grow
    //-------------------------------------------------------------------------------------------
    var transformationScale:CGFloat = 30
    
    
    //-------------------------------------------------------------------------------------------
    // color for the wave
    //-------------------------------------------------------------------------------------------
    var color = UIColor(red: 97/255, green: 47/255, blue: 105/255, alpha: 0.8)
    
    //-------------------------------------------------------------------------------------------
    // How many waves in the timed loader
    //-------------------------------------------------------------------------------------------
    var waveFrequency = 3
    
    //-------------------------------------------------------------------------------------------
    // Duration for a wave to grow to it's max scale.
    //-------------------------------------------------------------------------------------------
    var animationDuration:Double = 6
    
    
    //-------------------------------------------------------------------------------------------
    // Sets the rounded
    //-------------------------------------------------------------------------------------------
    var isRound:Bool = true
    
    private var views:[UIView] = [UIView]()
    static private let expandingViewWidth:Double = 10
    static private let expandingViewHeight:Double = 10
    private var transformation:CGAffineTransform  {
        get {
            return CGAffineTransformMakeScale(transformationScale, transformationScale)
        }
    }
    
    //-------------------------------------------------------------------------------------------
    //MARK: - Convenience Initialization
    //-------------------------------------------------------------------------------------------
    convenience init(frame: CGRect, scale:CGFloat, color:UIColor, waveFrequency:Int, duration:Double) {
        self.init(frame:frame)
        self.transformationScale = scale
        self.color               = color
        self.waveFrequency       = waveFrequency
        self.animationDuration   = duration
    }
    
    func loadWaves() {
        for _ in 0...waveFrequency {
            views.append( self.expandingView())
        }
    }
    
    func start() {
        self.loadWaves()
        // Delayscale is directly proportional to animation duration / wave frequency
        let delayScale:Double = Double(animationDuration) / Double(waveFrequency)
        var count:Double = 0
        for view in views {
            self.animate(view, delay: NSTimeInterval(count * delayScale))
            count += 1
            
        }
    }
}

//-------------------------------------------------------------------------------------------
//MARK: - Animation
//-------------------------------------------------------------------------------------------
extension TinderLoadingView {
    func animate(view:UIView , delay:NSTimeInterval) {
        UIView.animateWithDuration(Double(animationDuration), delay: delay, options: [.CurveLinear,.Repeat], animations: {
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
    
    
    func expandingView(width:Double = TinderLoadingView.expandingViewHeight) -> UIView {
        let waveView                = UIView(frame: CGRectMake(0,0,20,20))
        if self.isRound {
            self.makeRound(waveView)
        }
        waveView.backgroundColor    = self.color
        waveView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(waveView)
        self.configureConstraints(waveView, width: width)
        return waveView
    }
    
    func makeRound(view:UIView) {
        view.layer.cornerRadius = CGFloat(TinderLoadingView.expandingViewWidth / Double(2.0))
        view.clipsToBounds      = true
    }
    
    func configureConstraints(view:UIView, width:Double = TinderLoadingView.expandingViewHeight) {
        let viewDic = ["View":view]
        let viewMetrics =
        [
            "width" : width,
            "height": width
        ]
        //Sets Width
        let horizontalCons = NSLayoutConstraint.constraintsWithVisualFormat("H:[View(width)]", options:[], metrics: viewMetrics, views: viewDic);
        //Sets Height
        let verticalCons = NSLayoutConstraint.constraintsWithVisualFormat("V:[View(height)]", options:[], metrics: viewMetrics, views: viewDic);
        view.superview?.addConstraints(horizontalCons)
        view.superview?.addConstraints(verticalCons)
        
        //Sets Y-Position
        let centerVertically   = NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview, attribute: .CenterY, multiplier: 1, constant: 0)
        //Sets X-Position
        let centerHorizontally = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem:view.superview , attribute: .CenterX, multiplier: 1, constant: 0)
        view.superview?.addConstraints([centerVertically,centerHorizontally])
    }
    
}