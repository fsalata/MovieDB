//
//  UITableViewCellHelper.swift
//  MovieDB
//
//  Created by Fábio Salata on 14/10/19.
//  Copyright © 2019 Fabio Salata. All rights reserved.
//

import UIKit

extension UITableView {
    public func dequeueCell<T: UITableViewCell>(of type: T.Type,
                                                for indexPath: IndexPath,
                                                configure: @escaping ((T) -> Void) = { _ in }) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath)
        
        if let cell = cell as? T {
            configure(cell)
        }
        
        return cell
    }
}
