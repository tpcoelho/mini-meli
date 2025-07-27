//
//  ProductDetailsResponse.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 27/07/25.
//

import Foundation
import UIKit

struct ProductDetailsResponse {
    let product: Product
    let productDetails: ProductDetails
    let productDescription: ProductDescription
    let category: ProductCategory
    let images: [UIImage]?
}
