//
//  QRViewController.swift
//  Foodie
//
//  Created by Arthur on 2018/3/8.
//  Copyright © 2018年 Foodie. All rights reserved.
//

import Foundation
//import AVFoundation
import SwiftQRCode
import UIKit

//class QRViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate
class QRViewController : UIViewController
{
    var qrImage = UIImage()
    @IBOutlet var QRView: UIImageView!
    let scanner = QRCode()
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView?
    
//    var scanner = SSQRScanner()
    typealias CompletionHandler = () -> Void
    override func viewDidLoad()
    {
        self.QRView.image = qrImage
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
        }
        scanner.scanFrame = view.bounds
        // Get the back-facing camera for capturing videos
//        captureSession = AVCaptureSession()
//
//        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
//        let videoInput: AVCaptureDeviceInput
//
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//        } catch {
//            return
//        }
//
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed()
//            return
//        }
//
//        let metadataOutput = AVCaptureMetadataOutput()
//
//        if (captureSession.canAddOutput(metadataOutput)) {
//            captureSession.addOutput(metadataOutput)
//
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
//        } else {
//            failed()
//            return
//        }
//
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.layer.bounds
//        previewLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(previewLayer)
//
//        captureSession.startRunning()
      
       
    }
    
    @IBAction func scanQR(_ sender: Any)
    {
     
        self.QRView.isHidden = true
        scanner.startScan()
//        if #available(iOS 10.2, *) {
//            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
//            let captureDevice = deviceDiscoverySession.devices.first
//
//            do {
//                // Get an instance of the AVCaptureDeviceInput class using the previous device object.
//                let input = try AVCaptureDeviceInput(device: captureDevice!)
//
//                // Set the input device on the capture session.
//                captureSession?.addInput(input)
//
//                // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
//                let captureMetadataOutput = AVCaptureMetadataOutput()
//                captureSession?.addOutput(captureMetadataOutput)
//                // Set delegate and use the default dispatch queue to execute the call back
//                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//                captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//                // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
//                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//                videoPreviewLayer?.frame = view.layer.bounds
//                view.layer.addSublayer(videoPreviewLayer!)
//
//                // Start video capture.
//                captureSession?.startRunning()
//                qrCodeFrameView = UIView()
//
//                if let qrCodeFrameView = qrCodeFrameView {
//                    qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//                    qrCodeFrameView.layer.borderWidth = 2
//                    view.addSubview(qrCodeFrameView)
//                    view.bringSubview(toFront: qrCodeFrameView)
//                }
//            } catch {
//                // If any error occurs, simply print it out and don't continue any more.
//                print(error)
//                return
//            }
//        }
//        else
//        {
//            // Fallback on earlier versions
//        }
//
    }
//    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//        captureSession = nil
//    }
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        captureSession.stopRunning()
//
//        if let metadataObject = metadataObjects.first {
//            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
//            guard let stringValue = readableObject.stringValue else { return }
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            found(code: stringValue)
//        }
//
//        dismiss(animated: true)
////        // Check if the metadataObjects array is not nil and it contains at least one object.
////        if metadataObjects.count == 0 {
////            qrCodeFrameView?.frame = CGRect.zero
////            print("No QR code is detected")
////            return
////        }
////
////        // Get the metadata object.
////        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
////
////        if metadataObj.type == AVMetadataObject.ObjectType.qr {
////            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
////            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
////            qrCodeFrameView?.frame = barCodeObject!.bounds
////
////            if metadataObj.stringValue != nil {
////                print( metadataObj.stringValue)
////            }
////        }
//    }
//    func found(code: String) {
//        print(code)
//    }
    @IBAction func dismiss(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
