//
//  TestCollectionViewCell.swift
//  ListViewAutoHeightExtention_Example
//
//  Created by nothot on 2021/4/1.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    
    var text = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.numberOfLines = 0
        contentView.addSubview(label)
        setBorder(width: 1, color: .orange)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
//            make.width.equalTo(428)
            make.right.equalToSuperview()
            make.bottom.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        label.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
//    }
    
    func render(with text: String) -> Void {
        
        label.text = text
        self.text = text
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Void {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
