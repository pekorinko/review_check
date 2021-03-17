module MyTools
  class SeleniumTool
    def initialize(url)
      @url = url
      @d = Selenium::WebDriver.for :chrome
      wait = Selenium::WebDriver::Wait.new(timeout: 30)
      @d.get(@url)
      wait.until { @d.find_element(:class_name, 'lcorif').displayed? }
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

      @elements = []
      while true
        @elements =
          @d.find_elements(:css, '.gws-localreviews__google-review.WMbnJf')
        break if @elements.length >= 30
        @d.execute_script(
          "document.getElementsByClassName('review-dialog-list')[0].scrollTo(0,#{current_height})",
        )
        sleep 5
        current_height =
          @d.execute_script(
            'return document.getElementsByClassName("review-dialog-list")[0].scrollHeight',
          )
        sleep 5
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
          sleep 0.5
          content = review_item.find_element(:class_name, 'review-full-text')
          if content == nil
            content ||= ''
            return
          end
          review_count = get_review_count(local_guide)
          hash = { text: content.text, count: review_count, star: star_score }
          results.push(hash)
        rescue StandardError
          content = review_item.find_elements(:tag_name, 'span').last
          review_count = get_review_count(local_guide)
          hash = { text: content.text, count: review_count, star: star_score }
          results.push(hash)
        end
      end
      return results
    end

    def fetch_place
      facility = @d.find_element(:class_name, 'VUGnzb')
      facility_name = facility.find_element(:class_name, 'P5Bobd').text
      address = facility.find_element(:class_name, 'T6pBCe').text
      hash = { place_name: facility_name, address: address }
      return hash
    end
  end
end
