//
//  CustomHeaderView.swift
//  ShishaTime
//
//  Created by Mehmed Tukulic on 12/06/2020.
//  Copyright © 2020 Mehmed Tukulic. All rights reserved.
//

import Foundation
import UIKit

/// A kind of replacement for the UINavigationBar where it may be needed
@IBDesignable
class EliHeaderView: UIView {

    @IBInspectable
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleColor: UIColor! {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            label.textAlignment = .left
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }else {
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(titleLabel)
        let titleLabelConstraints = [
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    func setCenteredTitle(){
        titleLabel.textAlignment = .center
    }
    
}

