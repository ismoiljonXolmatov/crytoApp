//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Ismoiljon Xolmatov on 19.03.2024.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
