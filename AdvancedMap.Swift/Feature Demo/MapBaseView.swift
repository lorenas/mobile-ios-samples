//
//  MapBaseView.swift
//  Feature Demo
//
//  Created by Aare Undo on 19/06/2017.
//  Copyright © 2017 CARTO. All rights reserved.
//

import Foundation
import UIKit

class MapBaseView : UIView {
    
    var map: NTMapView!
    
    var popup: SlideInPopup!
    
    var buttons: [PopupButton]!
    
    var infoButton: PopupButton!
    var infoContent: InformationPopupContent!
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        initialize()
    }
    
    func initialize() {
        popup = SlideInPopup()
        
        addSubview(popup)
        sendSubview(toBack: popup)
        
        infoButton = PopupButton(imageUrl: "icon_info.png")
        addButton(button: infoButton)
        
        infoContent = InformationPopupContent()
    }
    
    override func layoutSubviews() {
        
        popup.frame = bounds
        
        if (map != nil) {
            map?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
        
        if (self.buttons == nil) {
            return
        }
        
        let count = CGFloat(self.buttons.count)
        
        let bottomPadding: CGFloat = 30
        let buttonWidth: CGFloat = 60
        let innerPadding: CGFloat = 25
        
        let totalArea = buttonWidth * count + (innerPadding * (count - 1))
        
        let w: CGFloat = buttonWidth
        let h: CGFloat = w
        let y: CGFloat = frame.height - (bottomPadding + h)
        var x: CGFloat = frame.width / 2 - totalArea / 2
        
        for button in buttons {
            button.frame = CGRect(x: x, y: y, width: w, height: h)
            
            x += w + innerPadding
        }
    }
    
    func addRecognizers() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.infoButtonTapped(_:)))
        infoButton.addGestureRecognizer(recognizer)
    }
    
    func removeRecognizers() {
        infoButton.gestureRecognizers?.forEach(infoButton.removeGestureRecognizer)
    }
    
    func infoButtonTapped(_ sender: UITapGestureRecognizer) {
        popup.setContent(content: infoContent)
        popup.popup.header.setText(text: "INFORMATION")
        popup.show()
    }
    
    func addBaseLayer() -> NTCartoOnlineVectorTileLayer {
        
        if (map == nil) {
            map = NTMapView()
            addSubview(map)
        }
        
        let layer = NTCartoOnlineVectorTileLayer(style: NTCartoBaseMapStyle.CARTO_BASEMAP_STYLE_DEFAULT)
        map.getLayers().add(layer)
        
        return layer!
    }
    
    func addButton(button: PopupButton) {
        
        if (buttons == nil) {
            buttons = [PopupButton]()
        }
        
        buttons.append(button)
        addSubview(button)
    }
    
}





