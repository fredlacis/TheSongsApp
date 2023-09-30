//
//  TSASlider.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 29/09/23.
//

import UIKit

class TSASlider: UISlider {
    
    var thumbDiameter: CGFloat = 14.0
    
    var trackHeight: CGFloat = 2.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupThumbImage()
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var customBounds = super.trackRect(forBounds: bounds)
        customBounds.size.height = trackHeight
        return customBounds
    }
    
    func setupThumbImage() {
        setThumbImage(thumbImage(withDiameter: thumbDiameter), for: .normal)
        setThumbImage(thumbImage(withDiameter: thumbDiameter * 1.4), for: .highlighted)
    }
    
    private func thumbImage(withDiameter diameter: CGFloat) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: diameter)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        return image?.withTintColor(thumbTintColor ?? .label).withRenderingMode(.alwaysOriginal)
    }
    
}
