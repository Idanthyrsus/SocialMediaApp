//
//  Post.swift
//  Navigation
//
//  Created by Alexander Korchak on 23.09.2022.
//

import Foundation

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

var post1 =  Post(author: "King Crimson",
                  description: "Starless and Bible Black. Anniversary edition of classic work from 1974. Lineup featuring Robert Fripp, Bill Bruford, John Wetton and David Cross. Traditionally classified as \"progressive rock\" this music having characteristics of free-jazz and psychedelic rock definitely goes beyond any definitions.",
                  image: "Starless",
                  likes: 345,
                  views: 200)

var post2 = Post(author: "NASA",
                      description: "This colorful image, taken by NASA’s Hubble Space Telescope, celebrates the Earth-orbiting observatory’s 28th anniversary of viewing the heavens, giving us a window seat to the universe’s extraordinary tapestry of stellar birth and destruction. At the center of the photo, a monster young star 200,000 times brighter than our Sun is blasting powerful ultraviolet radiation and hurricane-like stellar winds, carving out a fantasy landscape of ridges, cavities, and mountains of gas and dust.",
                      image: "nebula",
                      likes: 350,
                      views: 230)

var post3 = Post(author: "Religious Studies",
                 description: "The worship of the Sri Yantra is central to the Sri Vidya system of Hindu worship. It represents the Goddess in the form of Devi Tripura Sundari, the natural beauty of the three worlds: Bhu Loka (Physical Plane, Consciousness of the Physical Plane), Bhuvar Loka (Antariksha or Intermediate Space, Sub-Consciousness of the Prana) and Swar Loka (Svarga or Heaven or Super-Consciousness of the Divine Mind). The Sri Yantra is the symbol of Hinduism, which is based on the Hindu philosophy of the vedas. The Sri Yantra is the object of devotion in Sri Vidya.",
                 image: "shri1",
                 likes: 354,
                 views: 448)

var posts: [Post] = [post1, post2, post3]
