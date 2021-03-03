
module MyTools
    class SeleniumTool
        def initialize
            # @url = url
        end

        def access_url
            require 'selenium-webdriver'
            # require 'pry'
            d = Selenium::WebDriver.for :chrome

            wait = Selenium::WebDriver::Wait.new(timeout: 30)

            d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&tbs=lf:1,lf_ui:2&tbm=lcl&sxsrf=ALeKk02kwvfSNsLB4l_8mr3SiHxnZ-PcWA:1614321002524&q=%E5%B9%B3%E5%A1%9A+%E7%BE%8E%E5%AE%B9%E9%99%A2&rflfq=1&num=10&sa=X&ved=2ahUKEwiFpKKv9obvAhWBF4gKHei5A5EQjGp6BAgOEFA&biw=1028&bih=506#lrd=0x6019ad24985fadff:0x874520ac70b4b403,1,,,&rlfi=hd:;si:9747232893510661123,l,ChDlubPloZog576O5a656ZmiWiMKCue-juWuuSDpmaIiEeW5s-WhmiDnvo7lrrkg6ZmiKgIIA5IBCmhhaXJfc2Fsb26qARIQASoOIgrnvo7lrrkg6ZmiKAg;mv:[[35.3372193,139.3549256],[35.324571299999995,139.3464819]]')

            wait.until { d.find_element(:class_name, 'lcorif').displayed? }
        end
    end
end
# #スクロールをループで書く
# current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
# elements = []



# while true do
#     elements = d.find_elements(:css, '.gws-localreviews__google-review.WMbnJf')
#     if elements.length >= 1
#         break
#     end
#     d.execute_script("document.getElementsByClassName('review-dialog-list')[0].scrollTo(0,#{current_height})")
#     sleep 5
#     current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
#     sleep 5
# end

# puts elements.length

# reviews = []



# elements.each do |element|
#     review_item = element.find_element(:class_name, 'Jtu6Td')
#     local_guide = element.find_element(:class_name, 'FGlxyd')
#     star_score = element.find_element(:class_name,"PuaHbe").find_element(:class_name,"Fam1ne").attribute('aria-label').scan(/\d+\.\d+?/)[0].to_f

#     begin
#         # まず、 review-full-text というクラス名の要素を持つ（= もっと見るが表示されている）
#         # という前提で進める
#         review_item.find_element(:class_name, 'review-more-link').click
#         sleep 0.5
#         content = review_item.find_element(:class_name, 'review-full-text')
#         review_count = get_review_count(local_guide)

#         review = Review.new(content.text, review_count, star_score)

#         reviews.push(review)
        
#     rescue StandardError
#         content = review_item.find_elements(:tag_name, 'span').last
#         review_count = get_review_count(local_guide)

#         review = Review.new(content.text, review_count, star_score)

#         reviews.push(review)
#       end
# end

# shop = d.find_element(:class_name,'VUGnzb')
# shop_name = shop.find_element(:class_name, 'P5Bobd').text
# address = shop.find_element(:class_name, 'T6pBCe').text
# place = Place.new(shop_name, address)
# puts place.place_name
# puts place.address

# reviews.each.with_index(1) do |review,index|
#     puts "-----#{index}番目-----"
#     puts review.text
#     puts review.count
#     puts review.star
# end