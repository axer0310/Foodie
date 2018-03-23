//
//  PersonalAnnView.swift
//  Foodie
//
//  Created by Smile. on 21/03/2018.
//  Copyright © 2018 Foodie. All rights reserved.
//

import Foundation
import MapKit

class PersonalAnnView: MKAnnotationView
{
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside: Bool = rect.contains(point)
        if(!isInside)
        {
            for view in self.subviews
            {
                isInside = view.frame.contains(point)
                if isInside
                {
                    break
                }
            }
        }
        return isInside
    }
}
