//
//  AHLimberTabItem.swift
//  LimberTabbar
//
//  Created by Afshin Hoseini on 4/7/19.
//  Copyright © 2019 Afshin Hoseini. All rights reserved.
//

import Foundation
import UIKit

public class AHLimberTabBarItemView : UIView {
    
    var imgIcon : UIImageView!
    var tabBarItem : UITabBarItem?
    var onSelected : ((_:AHLimberTabBarItemView)->Void)!
    
    var iconTintColor = UIColor.gray {
        
        didSet {
            
            UIView.animate(withDuration: AnimationConfig.iconTintAnimDuration) {
                
                self.imgIcon.tintColor = self.iconTintColor
            }
            
        }
    }
    
    convenience init(tabBarItem : UITabBarItem) {
        
        self.init(frame: CGRect.zero)
        self.tabBarItem = tabBarItem
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func pulse() {
        
        UIView.animateKeyframes(withDuration: AnimationConfig.duration, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.alpha = 1
            })
            
        }, completion: nil)
    }
    
    func hide() {
        
        UIView.animate(withDuration: AnimationConfig.duration, animations: {
            
            self.alpha = 0
        })
        
    }
    
    func show() {
        
        UIView.animate(withDuration: AnimationConfig.duration) {
            
            self.alpha = 1
        }
    }
    
    func commonInit() {
        
        self.imgIcon = UIImageView (frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imgIcon.image = self.tabBarItem?.image
        imgIcon.contentMode = .scaleAspectFit
        imgIcon.tintColor = self.iconTintColor
        
        addSubview(imgIcon)
        
        
        if #available(iOS 9.0, *) {
            
            imgIcon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                
                imgIcon.topAnchor.constraint(equalTo: self.topAnchor),
                imgIcon.widthAnchor.constraint(equalTo: imgIcon.widthAnchor, multiplier: 1),
                imgIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imgIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapped(recognizer:)))
        addGestureRecognizer(tapGesture)
        
    }
    
    @objc func onTapped(recognizer: UITapGestureRecognizer) {
        
        self.onSelected(self)
    }
}
