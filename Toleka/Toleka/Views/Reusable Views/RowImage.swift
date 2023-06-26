//
//  RowImage.swift
//  Toleka
//
//  Created by Cédric Bahirwe on 26/06/2023.
//

import SwiftUI

struct RowImage: View {
    let image: String
    let size: CGSize
    init(_ image: String, size: CGSize = .init(width: 60, height: 60)) {
        self.image = image
        self.size = size
    }
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height)
    }
}

//struct RowImage_Previews: PreviewProvider {
//    static var previews: some View {
//        RowImage()
//    }
//}
