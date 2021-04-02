//
//  CollectionViewCell.swift
//  ListViewAutoHeightExtention
//
//  Created by mengminduan on 2021/4/2.
//

import UIKit

extension UITableView {
    
    public var forceFrameLayout: Bool {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.frameLayoutKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.frameLayoutKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var sizeCache: ListViewItemSizeCache {
        get {
            if let cache = objc_getAssociatedObject(self, &AssociatedKeys.cacheKey) as? ListViewItemSizeCache {
                return cache
            }else {
                let cache = ListViewItemSizeCache()
                objc_setAssociatedObject(self, &AssociatedKeys.cacheKey, cache, .OBJC_ASSOCIATION_RETAIN)
                return cache
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cacheKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private struct AssociatedKeys {
        
        static var cellDicKey = "cellDicKey"
        static var frameLayoutKey = "frameLayoutKey"
        static var cacheKey = "cacheKey"
    }
    
    var cellDic: [String: UITableViewCell] {
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKeys.cellDicKey) as? [String: UITableViewCell] ?? [:]
            if value.isEmpty {
                objc_setAssociatedObject(self, &AssociatedKeys.cellDicKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cellDicKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func dequeueLayoutCell(identifier: String, indexPath: IndexPath = IndexPath(item: 0, section: 0)) -> UITableViewCell {
        
        var cell: UITableViewCell
        if let cachedCell = cellDic[identifier] {
            cell = cachedCell
        }else {
            cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cellDic[identifier] = cell
        }
        return cell
    }
    
    public func sizeForItem<T>(identifier: String, indexPath: IndexPath = IndexPath(item: 0, section: 0), cacheByKey: T, configuration: (UITableViewCell) -> Void) -> CGSize  where T: Hashable {

        let size = sizeCache.size(for: cacheByKey)
        if size != .zero {
            return size
        }
        
        let cell = dequeueLayoutCell(identifier: identifier, indexPath: indexPath)
        cell.prepareForReuse()
        configuration(cell)
        
        let newSize = fittingSize(for: cell)
        sizeCache.cache(size: newSize, for: cacheByKey)
        return newSize
    }
    
    func fittingSize(for configuratedCell: UITableViewCell) -> CGSize {
        
        let contentViewWidth = frame.size.width
        var size = configuratedCell.frame.size
        size = CGSize(width: contentViewWidth, height: size.height)
        configuratedCell.frame.size = size

        let widthForceConstraint = NSLayoutConstraint(item: configuratedCell.contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: contentViewWidth)
        configuratedCell.contentView.addConstraint(widthForceConstraint)
        
        var fittingHeight: CGFloat = 0
        if forceFrameLayout == false, contentViewWidth > 0 {
            let aSize = configuratedCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            fittingHeight = aSize.height
        }
        if fittingHeight == 0 {
            let aSize = configuratedCell.sizeThatFits(CGSize(width: contentViewWidth, height: 0))
            fittingHeight = aSize.height
        }
        if fittingHeight == 0 {
            fittingHeight = 44
        }
        
        return CGSize(width: contentViewWidth, height: fittingHeight)
    }
}
