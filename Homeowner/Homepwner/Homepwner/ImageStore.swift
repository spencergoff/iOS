//
//  ImageStore.swift
//  Homepwner
//
//  Created by Spencer Goff on 7/9/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache <NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        
        /*turns image into JPEG data*/
        /*if let data = UIImageJPEGRepresentation(image, 0.5) { //0.5 is the compression quality, 1 is the highest quality
            let _ = try? data.write(to: url, options: [.atomic])
        }*/
        
        /*turns image into PNG data*/
        if let data = UIImagePNGRepresentation(image) {
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else { //compiler will only go past here if guard statement is true
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        /*when an image is deleted from the store, also delete it from filesystem*/
        let url = imageURL(forKey: key)
        //FileManager.default.removeItem(at: url)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError{
            print("Error removing image from disk: \(deleteError)")
        }
    }
    
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
}
