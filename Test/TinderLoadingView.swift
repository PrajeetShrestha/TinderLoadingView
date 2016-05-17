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
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
        
    }
}

//-------------------------------------------------------------------------------------------
//MARK: - Configuration
//-------------------------------------------------------------------------------------------
let transformationScale:CGFloat = 30
let expandingViewColor = UIColor(red: 63/255, green: 152/255, blue: 250/255, alpha: 0.7)
let waveFrequency = 3
let animationDuration:Double = 6
let expandingViewWidth:Double = 10
let expandingViewHeight:Double = 10

class TinderLoadingView: UIView {
    @IBOutlet var view: UIView!
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
        self.addExpandingView()
        
    }
    
    
    func load() {
        NSBundle.mainBundle().loadNibNamed("TinderLoadingView", owner: self, options: nil)
        self.view.frame = self.bounds
        self.addSubview(self.view)
        
        for _ in 0...waveFrequency {
            views.append( self.addExpandingView())
        }
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
    
    
    func addExpandingView() -> UIView {
        let roundView = RoundView(frame: CGRectMake(0,0,20,20))
        roundView.backgroundColor = expandingViewColor
        roundView.alpha = 0.7
        self.addSubview(roundView)
        roundView.translatesAutoresizingMaskIntoConstraints = false
        self.setWidthAndHeight(roundView)
        self.centerHV(roundView)
        return roundView
    }
    
    func setWidthAndHeight(view:UIView) {
        let viewDic = ["View":view]
        let viewMetrics =
        [
            "width" : expandingViewWidth,
            "height": expandingViewHeight
        ]
        let horizontalCons = NSLayoutConstraint.constraintsWithVisualFormat("H:[View(width)]", options:[], metrics: viewMetrics, views: viewDic);
        let veritcleCons = NSLayoutConstraint.constraintsWithVisualFormat("V:[View(height)]", options:[], metrics: viewMetrics, views: viewDic);
        view.superview?.addConstraints(horizontalCons)
        view.superview?.addConstraints(veritcleCons)
    }
    
    func centerHV(view:UIView) {
        let centerVertically =  NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview, attribute: .CenterY, multiplier: 1, constant: 0)
        let centerHorizontally =  NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem:view.superview , attribute: .CenterX, multiplier: 1, constant: 0)
        self.view.superview?.addConstraints([centerVertically,centerHorizontally])
    }
}