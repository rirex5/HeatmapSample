//
//  DrawHeatmapView.swift
//  HeatmapSample
//
//  Created by Mercury on 2019/08/05.
//  Copyright © 2019 Rirex. All rights reserved.
//

import UIKit

class DrawRectangleView: UIView {
    
    var color: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(color: UIColor) {
        self.color = color
    }
    
    /*
     表示を更新する必要が生ずると自動的に呼び出される.
     */
    override func draw(_ rect: CGRect) {
        // 長方形のUIBezierPathを生成.
        let heatmapRect: UIBezierPath = UIBezierPath(rect: CGRect(x:0, y:0, width:rect.width, height:rect.height)) // ,
        self.color.setFill()
        heatmapRect.fill() // 塗りつぶし
        heatmapRect.stroke() // 描画
    }
}
