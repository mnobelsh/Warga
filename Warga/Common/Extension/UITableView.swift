//
//  UITableView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 13/09/21.
//

import UIKit

public extension UITableView {
    
    func reloadCell(_ cell: UITableViewCell) {
        DispatchQueue.main.async {
            guard let indexPath = self.indexPath(for: cell) else { return }
            self.reloadRows(at: [indexPath], with: .none)
        }
    }
    
}
