//
//  ListViewItemSizeCache.swift
//  ListViewAutosizeExtention
//
//  Created by nothot on 2021/4/1.
//

import UIKit

class ListViewItemSizeCache: NSObject {
    
    private var sizeCacheForPortrait: [AnyHashable: CGSize] = [:]

    private var sizeCacheForLandscape: [AnyHashable: CGSize] = [:]

    func sizeCacheForCurrent() -> [AnyHashable: CGSize] {
        
        let cache = UIDeviceOrientationIsPortrait(UIDevice.current.orientation) ? sizeCacheForPortrait : sizeCacheForLandscape
        
        return cache
    }
    
    func existsSize(for key: AnyHashable) -> Bool {
        
        if let _ = sizeCacheForCurrent()[key] {
            return true
        }
        return false
    }
    
    func size(for key: AnyHashable) -> CGSize {
        
        if let size = sizeCacheForCurrent()[key] {
            return size
        }
        return .zero
    }
    
    func cache(size: CGSize, for key: AnyHashable) -> Void {
        
        let isPortrait = UIDeviceOrientationIsPortrait(UIDevice.current.orientation)
        if isPortrait {
            sizeCacheForPortrait[key] = size
        }else {
            sizeCacheForLandscape[key] = size
        }
    }
    
    func deleteSizeCache(for key: AnyHashable) -> Bool {

        if let _ = sizeCacheForCurrent()[key] {
            var cache = sizeCacheForCurrent()
            cache.removeValue(forKey: key)
            return true
        }
        return false
    }
    
    func deleteAllSizeCache() -> Void {
        
        sizeCacheForPortrait.removeAll()
        sizeCacheForLandscape.removeAll()
    }
}
