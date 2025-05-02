//
//  DataScannerView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    @Binding var shouldStartScanning: Bool
    @Binding var scannedCode: String
    var dataToScanFor: Set<DataScannerViewController.RecognizedDataType>
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let dataScannerVC = DataScannerViewController(
            recognizedDataTypes: dataToScanFor,
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        dataScannerVC.delegate = context.coordinator
        return dataScannerVC
    }
    
    func updateUIViewController(_ uiView: DataScannerViewController, context: Context) {
        if shouldStartScanning {
            try? uiView.startScanning()
        } else {
            uiView.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScannerView
        
        init(_ parent: DataScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in allItems {
                switch item {
                case .barcode(let barcode):
                    parent.scannedCode = barcode.payloadStringValue ?? "Unable to decode the scanned code"
                default:
                    continue
                }
            }
        }
    }
}
