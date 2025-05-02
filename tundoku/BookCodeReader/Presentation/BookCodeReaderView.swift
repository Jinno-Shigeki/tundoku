//
//  BookCodeReaderView.swift
//  tundoku
//
//  Created by 神野成紀 on 2025/04/30.
//

import SwiftUI
import VisionKit

struct BookCodeReaderView: View {
    @State var isStartScanner = true
    @State private var scannedCode = ScannedCode("") {
        didSet {
            if scannedCode.isValid {
                isStartScanner = false
                fetchBookCode(scannedCode.code)
            }
        }
    }
    
    let fetchBookCode: (_ code: String) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DataScannerView(
                shouldStartScanning: $isStartScanner,
                scannedCode: $scannedCode.code,
                dataToScanFor: [.barcode()]
            )
            
            if !scannedCode.isValid {
                Text("Please scan ISBN code")
                    .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    BookCodeReaderView { code in
        print(code)
    }
}
