//
//  BarcodeScanner.swift
//  Rattvisekollen
//
//  Created by Fredrik Bystam on 15/08/15.
//  Copyright © 2015 nickenil_byrreb. All rights reserved.
//

import UIKit
import AVFoundation

protocol BarcodeOutputDelegate {
    
    func scannerDidOutputData(data: String)
    
}

class BarcodeScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    let previewView: UIView
    let delegate: BarcodeOutputDelegate
    
    let captureSession = AVCaptureSession()
    var captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    var metadataOutput = AVCaptureMetadataOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    init(previewView: UIView, delegate: BarcodeOutputDelegate) {
        self.previewView = previewView
        self.delegate = delegate
        super.init()
        
        setupCamera()
    }
    
    internal func startScanning() {
        self.captureSession.startRunning()
    }
    
    internal func stopScanning() {
        self.captureSession.stopRunning()
    }
    
    func setupCamera() {
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        do {
            let input = try AVCaptureDeviceInput(device: self.captureDevice)
            
            if let device = self.captureDevice {
                try device.lockForConfiguration()
                
                if device.isFocusModeSupported(.ContinuousAutoFocus) {
                    device.focusMode = .ContinuousAutoFocus
                }
                if device.autoFocusRangeRestrictionSupported {
                    device.autoFocusRangeRestriction = .Near
                }
                device.unlockForConfiguration()
            }
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
            }
            
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            if let videoPreviewLayer = self.videoPreviewLayer {
                videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                videoPreviewLayer.frame = self.previewView.bounds
                self.previewView.layer.addSublayer(videoPreviewLayer)
            }
            
            let queue = dispatch_queue_create("se.rattvisa.capture_queue", DISPATCH_QUEUE_CONCURRENT)
            self.metadataOutput.setMetadataObjectsDelegate(self, queue: queue)
            if self.captureSession.canAddOutput(self.metadataOutput) {
                self.captureSession.addOutput(self.metadataOutput)
                self.metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeQRCode]
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        var barcodeObjects : Array<AVMetadataMachineReadableCodeObject> = []

        for metadataObject : AnyObject in metadataObjects {
            if let videoPreviewLayer = self.videoPreviewLayer {

                let transformedMetadataObject = videoPreviewLayer.transformedMetadataObjectForMetadataObject(metadataObject as! AVMetadataObject)
                if transformedMetadataObject.isKindOfClass(AVMetadataMachineReadableCodeObject.self) {
                    let barcodeObject = transformedMetadataObject as! AVMetadataMachineReadableCodeObject
                    barcodeObjects.append(barcodeObject)
                }
            }
        }
        
        for barcode : AVMetadataMachineReadableCodeObject in barcodeObjects {
            self.delegate.scannerDidOutputData(barcode.stringValue)
        }
    }
}
