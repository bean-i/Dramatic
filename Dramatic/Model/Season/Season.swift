//
//  Season.swift
//  Dramatic
//
//  Created by 김도형 on 3/23/25.
//

import Foundation

struct Season: Decodable, Hashable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case episodes
    }
}

extension Season {
    struct Episode: Decodable, Hashable {
        let id: Int
        let episodeNumber: Int
        let airDate: String?
        let runtime: Int?
        let stillPath: String?
        let overview: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case episodeNumber = "episode_number"
            case airDate = "air_date"
            case runtime
            case stillPath = "still_path"
            case overview
        }
    }
}

extension Season {
    static var mock: Season {
        Season(
            id: 342423,
            name: "리미티드 시리즈",
            overview: "",
            posterPath: "/752qpqTFHrGlZoA5v1viSXsnk3w.jpg",
            episodes: [
                Episode(
                    id: 4195779,
                    episodeNumber: 1,
                    airDate: "2025-03-07",
                    runtime: 58,
                    stillPath: "/7NZeS2RsCDb7m8QeB3jDf0EkAd.jpg",
                    overview: "억척스러운 어머니 아래서 야무지고 똘똘하게 자라난 애순. 그 작은 마음속에 헤아릴 수 없도록 많은 꿈을 품고 산다. 하지만 자꾸 서러운 일들이 닥치며 어린 애순을 힘들게 한다."
                ),
                Episode(
                    id: 5853442,
                    episodeNumber: 2,
                    airDate: "2025-03-07",
                    runtime: 54,
                    stillPath: "/eJ3uRHVwn1qHNfGfHaxBM3ePQJX.jpg",
                    overview: "애순과 관식 사이에 유채꽃처럼 환한 사랑이 피어난다. 인생은 낙장불입, 굳게 마음먹고 사랑의 모험을 감행하는 두 청춘. 그런데 인생은 예측 불허, 첫걸음부터 험한 고비에 부닥칠 줄이야."
                ),
                Episode(
                    id: 5853443,
                    episodeNumber: 3,
                    airDate: "2025-03-07",
                    runtime: 63,
                    stillPath: "/9zNntKC89arsqaDXzwjqpsdXSCC.jpg",
                    overview: "떠들썩한 소동 끝에 제주로 돌아온 애순과 관식. 마음대로 되는 게 하나 없는 애순은 말도 안 되는 운명에 자신을 내맡기려 한다. 애순만 보고 살던 관식은 애타는 마음을 어찌하면 좋을까."
                ),
                Episode(
                    id: 5853444,
                    episodeNumber: 4,
                    airDate: "2025-03-07",
                    runtime: 60,
                    stillPath: "/vw1mCoPLA5KX2UKcA7m1xoJCM67.jpg",
                    overview: "화창한 여름날과 더불어 행복을 꿈꾸던 신혼부부. 하지만 시집살이란 그리 녹록하지가 않다. 모진 구박을 받으면서도 애순은 아이에게만은 다른 인생을 선물하고 싶다."
                ),
                Episode(
                    id: 5853445,
                    episodeNumber: 5,
                    airDate: "2025-03-14",
                    runtime: 61,
                    stillPath: "/lZ2188KeEJ1fDmRKYJT0EpO7QNz.jpg",
                    overview: "관식은 어떻게든 일자리를 구하려 애쓰고 애순은 가족 걱정에 눈물이 난다. 피가 마르는 그 순간, 두 사람에게 찾아든 한 줄기 희망. 애순은 제주에서 활짝 날개를 펴고 날아오르려 한다."
                ),
                Episode(
                    id: 5853446,
                    episodeNumber: 6,
                    airDate: "2025-03-14",
                    runtime: 57,
                    stillPath: "/yngwMfWrrBOL3Q8Waf0ZWr3aMuQ.jpg",
                    overview: "새로운 인생의 기쁨을 맛보며 날마다 행복한 애순과 관식. 하지만 하늘이 변덕을 부리던 어느 여름날, 어린 부부에게 사나운 태풍이 몰아친다."
                ),
                Episode(
                    id: 5853447,
                    episodeNumber: 7,
                    airDate: "2025-03-14",
                    runtime: 64,
                    stillPath: "/uwegx3Jo0gOt34RuZWsec1iEoqP.jpg",
                    overview: "구린 구석이 많은 상대 후보에 맞서, 애순이 도동리 최초 여성 계장에 도전한다. 한편, 생각지도 못한 유혹을 받는 금명. 엄청난 대가 앞에 금명의 양심이 시험에 든다."
                ),
                Episode(
                    id: 5853448,
                    episodeNumber: 8,
                    airDate: "2025-03-14",
                    runtime: 63,
                    stillPath: "/hFPydfoHeMswbNTC79ajfWkKa7G.jpg",
                    overview: "하고 싶은 것도 많고 되고 싶은 것도 많은 금명. 드디어 일본에서 유학할 기회를 얻는다. 어쩌면 애순과 관식도 오랫동안 바라왔던 꿈을 하나 이룰 수 있을 것 같다."
                ),
                Episode(
                    id: 5853449,
                    episodeNumber: 9,
                    airDate: "2025-03-21",
                    runtime: 49,
                    stillPath: "/w4gP5gmHWHgcD4MMClmkjOHOnYI.jpg",
                    overview: "비좁은 아파트에서 복닥거리며 사는 애순과 관식. 어딘가 관식을 닮은 10대 아들 은명 때문에 두 사람은 새로운 시험과 맞닥뜨린다. 한편, 금명은 새로운 기대와 함께 서울 생활을 시작한다."
                ),
                Episode(
                    id: 5853450,
                    episodeNumber: 10,
                    airDate: "2025-03-21",
                    runtime: 57,
                    stillPath: "/pRBE7fYguyogo66MBtGWY267FXJ.jpg",
                    overview: "금명은 남다른 인연으로 만난 동료와 점점 가까워진다. 밤마다 찾아오는 불길한 꿈에 걱정을 떨치지 못하는 애순. 엄마의 직감이 뭔가를 알려주려 하는지도 모른다."
                ),
                Episode(
                    id: 5853451,
                    episodeNumber: 11,
                    airDate: "2025-03-21",
                    runtime: 63,
                    stillPath: "/5xDLTMIlUupOV9cHAHXrmJ1ZlPY.jpg",
                    overview: "변함없이 자신을 아껴주는 연인과 결혼을 준비하는 금명. 하지만 마음 깊은 곳 불안함은 어찌할 수가 없다. 애순의 첫사랑이 그랬듯이, 금명의 첫사랑도 행복한 결말을 맞을 수 있을까."
                ),
                Episode(
                    id: 5853452,
                    episodeNumber: 12,
                    airDate: "2025-03-21",
                    runtime: 59,
                    stillPath: "/bcmHk35qjoRmeVqbFwtzR4VOwRM.jpg",
                    overview: "상처가 남은 채로 제주에 내려온 금명. 오랜만에 어린 시절로 돌아간 듯 부모와 따뜻한 시간을 보낸다. 속절없이 흐르는 세월 속에 애순은 사랑하는 이들과 보내는 시간이 새삼 소중해진다."
                ),
                Episode(
                    id: 5853453,
                    episodeNumber: 13,
                    airDate: "2025-03-28",
                    runtime: nil,
                    stillPath: nil,
                    overview: ""
                ),
                Episode(
                    id: 5853454,
                    episodeNumber: 14,
                    airDate: "2025-03-28",
                    runtime: nil,
                    stillPath: nil,
                    overview: ""
                ),
                Episode(
                    id: 5853455,
                    episodeNumber: 15,
                    airDate: "2025-03-28",
                    runtime: nil,
                    stillPath: nil,
                    overview: ""
                ),
                Episode(
                    id: 5853456,
                    episodeNumber: 16,
                    airDate: "2025-03-28",
                    runtime: nil,
                    stillPath: nil,
                    overview: ""
                )
            ]
        )
    }
}
