//
//  Book.swift
//  BookAppUIWithAnime
//
//  Created by mark on 2023-07-04.
//

import Foundation

/// Book Model
struct Book: Identifiable
{
    var id: String = UUID().uuidString
    var title: String
    var imageName: String
    var author: String
    var rating: Int
    var bookViews: Int
}

var sampleBooks: [Book] = [
    .init(title: "Harry Potter and the Philosopher's Stone", imageName: "1-ne", author: "J. K. Rowling", rating: 5, bookViews: 12000),
    .init(title: "Harry Potter and the Chamber of Secrets", imageName: "Book 2", author: "J. K. Rowling", rating: 4, bookViews: 7700),
    .init(title: "Harry Potter and the Prisoner of Azkaban", imageName: "Book 3", author: "J. K. Rowling", rating: 5, bookViews: 6500),
    .init(title: "Harry Potter and the Goblet of Fire", imageName: "Book 4", author: "J. K. Rowling", rating: 5, bookViews: 6500),
    .init(title: "Harry Potter and the Order of the Phoenix", imageName: "Book 5", author: "J. K. Rowling", rating: 4, bookViews: 6500)
]
