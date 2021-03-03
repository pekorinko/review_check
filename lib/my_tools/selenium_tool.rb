
module MyTools
    class SeleniumTool
        def initialize(text,count,star)
            @text = text
            @count = count
            @star = star
        end

        def access_url
            
            
            d = Selenium::WebDriver.for :chrome
            
            wait = Selenium::WebDriver::Wait.new(timeout: 30)
            
            # d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')
            # d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&biw=1080&bih=574&tbm=lcl&ei=NVk3YJ-JD4GvoASZtoy4DA&q=%E5%B9%B3%E5%A1%9A%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&oq=%E5%B9%B3%E5%A1%9A%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&gs_l=psy-ab.3..0i7i30k1l8.87128.89315.0.89847.12.12.0.0.0.0.182.1378.3j8.11.0....0...1c.1j4.64.psy-ab..6.5.710...0j0i67k1j0i7i4i30k1.0.m96OrDiFWGs#lrd=0x6019acd8a79c5fb5:0x99f75ae1b56fbb69,1,,,&rlfi=hd:;si:11094436132508646249,l,ChLlubPloZrjgIDnvo7lrrnpmaJaIwoK576O5a65IOmZoiIR5bmz5aGaIOe-juWuuSDpmaIqAggDkgEKaGFpcl9zYWxvbqoBEhABKg4iCue-juWuuSDpmaIoCA;mv:[[35.3525839,139.3576149],[35.3243199,139.31230779999999]];start:20')
            d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&tbs=lf:1,lf_ui:2&tbm=lcl&sxsrf=ALeKk02kwvfSNsLB4l_8mr3SiHxnZ-PcWA:1614321002524&q=%E5%B9%B3%E5%A1%9A+%E7%BE%8E%E5%AE%B9%E9%99%A2&rflfq=1&num=10&sa=X&ved=2ahUKEwiFpKKv9obvAhWBF4gKHei5A5EQjGp6BAgOEFA&biw=1028&bih=506#lrd=0x6019ad24985fadff:0x874520ac70b4b403,1,,,&rlfi=hd:;si:9747232893510661123,l,ChDlubPloZog576O5a656ZmiWiMKCue-juWuuSDpmaIiEeW5s-WhmiDnvo7lrrkg6ZmiKgIIA5IBCmhhaXJfc2Fsb26qARIQASoOIgrnvo7lrrkg6ZmiKAg;mv:[[35.3372193,139.3549256],[35.324571299999995,139.3464819]]')
            
            wait.until { d.find_element(:class_name, 'lcorif').displayed? }
            
            #スクロールをループで書く
            current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
            elements = []
            
            while true do
                elements = d.find_elements(:css, '.gws-localreviews__google-review.WMbnJf')
                if elements.length >= 1
                    break
                end
                d.execute_script("document.getElementsByClassName('review-dialog-list')[0].scrollTo(0,#{current_height})")
                sleep 5
                current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
                sleep 5
            end
            
            puts elements.length
            
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
        end
    end
end

class Review
    attr_reader :text, :count, :star

    def initialize(text, count, star)
        @text = text
        @count = count
        @star = star
    end

end


class Place
    attr_reader :place_name, :address
    
    def initialize(place_name, address)
        @place_name = place_name
        @address = address
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