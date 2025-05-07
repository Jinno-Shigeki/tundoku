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
    @State private var scannedCode = ScannedCode("")
    
    @Environment(\.dismiss) private var dismiss
    
    let fetchBookCode: (_ code: String) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DataScannerView(
                shouldStartScanning: $isStartScanner,
                scannedCode: $scannedCode.code,
                dataToScanFor: [.barcode()]
            )
            
            if !scannedCode.isValid {
                VStack {
                    Text("ISBNコードを読み込んでください")
                        .font(.caption.bold())
                        .padding(.bottom, 8)
                    Text("バーコードが二つある場合は、上段のバーコードを読み取ってください。")
                        .font(.caption2)
                        .padding([.bottom, .horizontal], 32)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .onChange(of: scannedCode) { _, newValue in
            if newValue.isValid {
                isStartScanner = false
                fetchBookCode(newValue.code)
                dismiss()
            }
        }
    }
}

#Preview {
    BookCodeReaderView { code in
        print(code)
    }
}
