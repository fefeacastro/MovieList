struct Movie: Decodable, Equatable {
    let title: String?
    let overview: String?
    let adult: Bool?
    let posterPath: String?
    let voteAverage: Double?
}
