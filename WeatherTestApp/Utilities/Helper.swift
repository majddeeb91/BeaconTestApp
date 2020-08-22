//
//  Helper.swift
//  WeatherTestApp
//
//  Created by Majd Deeb on 26/03/2020.
//  Copyright © 2020 Majd Deeb. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Kingfisher


struct Helper {
    struct constatns {
        static let imageBaseUrl : String = ""//http:"
    }
    

    
    struct HelperMethods {
        static func isValidEmail(emailStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: emailStr)
        }
        
        static func convertEnNumber(toFarsi number: String) -> String {
            var NumberString = ""
            let Formatter = NumberFormatter()
            let locale: NSLocale? = NSLocale(localeIdentifier: "EN")
            Formatter.locale = locale! as Locale
            let newNum = Formatter.number(from: number)
            if newNum != nil {
                NumberString = "\(newNum!)"
                print("\(NumberString)")
            }
            return NumberString
        }
        
        
        
        
        
        static func mimeTypeForPath(path: String) -> String {
            let url = NSURL(fileURLWithPath: path)
            let pathExtension = url.pathExtension
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
                if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                    return mimetype as String
                }
            }
            return "application/octet-stream"
            //return pathExtension!
        }
        
        
        
        static func extensionForPath(path: String) -> String {
            let url = NSURL(fileURLWithPath: path)
            return url.pathExtension!
        }
        
        
        static func documentsPathForImages(filename: String) -> String {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsPath: String = paths[0]
            
            var url = URL(fileURLWithPath: documentsPath)
            
            url.appendPathComponent(filename, isDirectory: false)
            print(url.pathComponents)
            return url.path
        }
        
        static func getMimeTypeForFile(data:Data) -> String{
            var c: UInt8 = 0
            if data.count != 0 {
                data.copyBytes(to: &c, count: 1)
                switch c {
                case 0xFF:
                    return "image/jpeg"
                case 0x89:
                    return "image/png"
                case 0x47:
                    return "image/gif";
                case 0x4D:
                    return "image/tiff";
                case 0x25:
                    return "application/pdf"
                case 0x50:
                    return "application/zip"
                case 0xD0:
                    return "application/vnd.ms-excel"
                case 99:
                    return "audio/m4a"
                default:
                    return ""
                }
            }
            return ""
        }
        
        static func getTimeStringFromTimeStamp(timestamp: Double) -> String{
            // ATTENTION: we divided on 1000 becasue of time in milliseconds
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp / 1000))
            let timeFormatter =  DateFormatter()
           // timeFormatter.timeZone = TimeZone.current
            timeFormatter.dateFormat = "h:mm a"
            timeFormatter.amSymbol = "AM"
            timeFormatter.pmSymbol = "PM"
            let timeString = timeFormatter.string(from: date)
            
            return timeString
        }
        
        
        static func getDateStringFromTimeStamp(timestamp: Double) -> String{
            // ATTENTION: we divided on 1000 becasue of time in milliseconds
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp / 1000))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current//aName as TimeZone
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
       static  func getHightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
          
        label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text

            label.sizeToFit()
            return label.frame.height
        }

        

        
    }
    
    
    static func getImageFromUrl(url: URL) {
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            print(image as Any)
        })
        
    }
    
    
    
    static func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    static func getThumbnailImageFromVideoUrlRequest(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
        
    }
    
    
}

