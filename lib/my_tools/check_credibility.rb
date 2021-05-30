module MyTools
  class CheckCredibility
    attr_reader :place_id

    def initialize(place_id)
      @place_id = place_id
    end

    def credibility(user_id)
      reviews = Review.where(place_id: @place_id)

      selected_reviews =
        reviews.filter_map do |review|
          review if review.text.size >= 50 and review.count >= 20
        end

      texts = reviews.map { |review| review.text }
      stars = reviews.map { |review| review.star }
      counts = reviews.map { |review| review.count }
      selected_stars =
        selected_reviews.map { |selected_review| selected_review.star }

      total = 0
      count_total = 0
      text_total = 0
      selected_star_total = 0

      texts.each { |text| text_total = text_total + text.size }
      stars.each { |star| total = total + star }
      counts.each { |count| count_total = count_total + count }
      selected_stars.each do |selected_star|
        selected_star_total = selected_star_total + selected_star
      end

      place = Place.find_by(id: @place_id)

      count_ave = count_total / counts.length
      text_ave = text_total / texts.length
      begin
        star_ave = selected_star_total / selected_stars.length
        credible_star_ave = star_ave.to_f.floor(1)
      rescue StandardError
        credible_star_ave = '厳選された星評価基準を満たす投稿がありません'
      end

      Result.create!(
        star_ave: place.star_ave,
        count_ave: count_ave,
        text_ave: text_ave,
        credible_star_ave: credible_star_ave,
        place_id: @place_id,
        user_id: user_id,
      )
    end
  end
end
