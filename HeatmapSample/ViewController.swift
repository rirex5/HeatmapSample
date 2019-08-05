//
//  ViewController.swift
//  HeatmapSample
//
//  Created by Mercury on 2019/08/05.
//  Copyright © 2019 Rirex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var heatmapView: UIView!
    
    // 注：viewDidLoadではない
    override func viewDidAppear(_ animated: Bool) {
        // 背景画像をセット
        let backgroudImage = UIImage(named: "Nuko.jpg")
        heatmapView.backgroundColor = UIColor(patternImage: backgroudImage!)
        // ヒートマップの作成 (0〜255の範囲)
        let heatmap: [[CGFloat]] = [[255, 0, 0, 0, 0, 0, 0, 0],
                                    [0, 255, 0, 0, 0, 0, 0, 0],
                                    [0, 0, 255, 0, 0, 0, 0, 0],
                                    [0, 0, 0, 255, 0, 0, 0, 0],
                                    [0, 0, 0, 0, 255, 0, 0, 0],
                                    [0, 0, 0, 0, 0, 255, 0, 0],
                                    [0, 0, 0, 0, 0, 0, 255, 0],
                                    [0, 0, 0, 0, 0, 0, 0, 255]]
        
        drawHeatmap(targetView: heatmapView, heatmap: heatmap, opacity: 0.5)
    }
    
    func drawHeatmap(targetView: UIView, heatmap: [[CGFloat]], opacity: Float) {
        // 描画するViewの縦横幅を取得
        let heatmapViewHeight = targetView.frame.height
        let heatmapViewWidth = targetView.frame.width
        // ヒートマップのサイズを取得
        let ySize = heatmap.count
        let xSize = heatmap[0].count
        // 1ピクセル毎の大きさを計算
        let rectangleSizeHeight = Int(round(heatmapViewHeight / CGFloat(ySize)))
        let rectangleSizeWidth = Int(round(heatmapViewWidth / CGFloat(xSize)))
        // ヒートマップの作成
        for i in 0..<heatmap.count {
            for j in 0..<heatmap[i].count {
                let color = calcHeatmapColor(heatmap[i][j])
                var myDrawView: DrawRectangleView!
                myDrawView = DrawRectangleView(frame: CGRect(x:j * rectangleSizeWidth, y:i * rectangleSizeHeight, width:rectangleSizeWidth, height:rectangleSizeHeight))
                myDrawView.setColor(color: color)
                myDrawView.layer.opacity = opacity
                targetView.addSubview(myDrawView)
            }
        }
        
    }
    
    func calcHeatmapColor(_ a: CGFloat) -> UIColor {
        var redcolor = CGFloat()
        var greencolor = CGFloat()
        var bluecolor = CGFloat()
        if a < 128 {
            redcolor = 0
        }else if a > 127 && a < 191 {
            redcolor = (a - 127)*4
        }else if a > 190 {
            redcolor = 255
        }
        if a >= 64 && a <= 191 {
            greencolor = 255
        }else if a < 64 {
            greencolor = a * 4
        }else {
            greencolor = 256 - (a - 191)*4
        }
        if a <= 64{
            bluecolor = 255
        }else if a > 64 && a < 127 {
            bluecolor = 255 - (a - 64)*4
        }else if a >= 127 {
            bluecolor = 0
        }
        let color = UIColor(red:redcolor / 255.0, green: greencolor / 255.0, blue:bluecolor / 255.0, alpha:1.0)
        return color
    }

}

