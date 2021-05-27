module MyTools
  class SeleniumTool
    def initialize(url)
      @url = url
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      @d = Selenium::WebDriver.for :chrome, options: options
      wait = Selenium::WebDriver::Wait.new(timeout: 30)
      @d.get(@url)
      begin
        wait.until { @d.find_element(:class_name, 'lcorif').displayed? }
      rescue StandardError
        puts '例外が発生しました'
      end
    end

    def get_review_count(local_guide)
      if local_guide.find_elements(:class_name, 'A503be').size > 0
        local_guide_info = local_guide.find_element(:class_name, 'A503be')
        result = local_guide_info.text.match(/(\d+)\ 件のレビュー/)
        if result.nil?
          return 1
        else
          result[0].to_i
        end
      else
        return local_guide.text.scan(/(\d+)\ 件のレビュー/)[0].to_i
      end
    end

    def access_url
      current_height =
        @d.execute_script(
          'return document.getElementsByClassName("review-dialog-list")[0].scrollHeight',
        )
      previous_length = 0
      @elements = []
      while true
        @elements =
          @d.find_elements(:css, '.gws-localreviews__google-review.WMbnJf')

        # 取得した口コミが30件以上に達した時、または1個前で取得した口コミ件数と次のスクロールで取得した件数を比較して両者が同じであればループを抜ける処理
        break if @elements.length >= 30 || previous_length == @elements.length
        previous_length = @elements.length
        @d.execute_script(
          "document.getElementsByClassName('review-dialog-list')[0].scrollTo(0,#{current_height})",
        )

        current_height =
          @d.execute_script(
            'return document.getElementsByClassName("review-dialog-list")[0].scrollHeight',
          )
      end
    end

    def fetch_reviews
      access_url
      results = []

      @elements.each do |element|
        review_item = element.find_element(:class_name, 'Jtu6Td')
        local_guide = element.find_element(:class_name, 'FGlxyd')
        star_score =
          element
            .find_element(:class_name, 'PuaHbe')
            .find_element(:class_name, 'Fam1ne')
            .attribute('aria-label')
            .scan(/\d+\.\d+?/)[
            0
          ].to_f

        begin
          review_item.find_element(:css, '.review-more-link').click

          @content =
            review_item.find_element(:class_name, 'review-full-text') || ''
          review_count = get_review_count(local_guide)
          hash = { text: @content.text, count: review_count, star: star_score }
          results.push(hash)
        rescue StandardError
          @content = review_item.find_elements(:tag_name, 'span').last || ''
          review_count = get_review_count(local_guide)
          hash = { text: @content.text, count: review_count, star: star_score }
          results.push(hash)
        end
      end
      return results
    end

    def fetch_place
      begin
        star_ave =
          @d
            .find_element(:class_name, 'review-score-container')
            .find_element(:class_name, 'Aq14fc')
            .text

        facility = @d.find_element(:class_name, 'VUGnzb')
        facility_name = facility.find_element(:class_name, 'P5Bobd').text
        address = facility.find_element(:class_name, 'T6pBCe').text
        hash = {
          place_name: facility_name,
          address: address,
          star_ave: star_ave,
        }
        return hash
      rescue StandardError
        puts '口コミがありません'
      end
    end
  end
end
