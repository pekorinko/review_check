module MyTools
  class CheckCredibility
    def initialize(place_id)
      @place_id = place_id
    end

    def credibility
      reviews = Review.where(place_id: @place_id)
      puts '====================='
      puts 'reviews↓'
      puts reviews
      puts @place_id
      puts '====================='
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

      # 以下のコード試したけど駄目だった
      # place = Place.find_or_create_by(id: @place_id)
      puts '---------------'
      puts place
      puts @place_id
      puts '---------------'

      star_ave = total / stars.length
      count_ave = count_total / counts.length
      text_ave = text_total / texts.length
      begin
        credible_star_ave = selected_star_total / selected_stars.length
      rescue StandardError
        credible_star_ave = '厳選された星評価基準を満たす投稿がありません'
      end

      # place_name: place.place_name, address: place.address,の部分はPlaceと関連付けを行っているため書き方変える必要あり
      Result.create!(
        place_name: place.place_name,
        address: place.address,
        star_ave: star_ave,
        count_ave: count_ave,
        text_ave: text_ave,
        credible_star_ave: credible_star_ave,
      )
    end
  end
end
