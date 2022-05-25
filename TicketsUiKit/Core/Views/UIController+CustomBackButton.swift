//
//  UIController+CustomBackButton.swift
//  TicketsUiKit
//
//  Created by Stevan Rakic on 25.5.22..
//

import Foundation
import UIKit

extension UIViewController {
    
    func setCustomBack()
    {
        //Back buttion
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal), for: UIControl.State())
        btnLeftMenu.addTarget(self, action: #selector(DetailViewController.onClickBack), for: UIControl.Event.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func onClickBack()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
