

module MyTools
    class SeleniumTool
        attr_reader :text
        def initialize(text,count,star)
            @text = text
            @count = count
            @star = star
        end

        def access_url
            
            
            d = Selenium::WebDriver.for :chrome
            
            wait = Selenium::WebDriver::Wait.new(timeout: 30)
            
            # d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&tbs=lf:1,lf_ui:2&tbm=lcl&sxsrf=ALeKk02kwvfSNsLB4l_8mr3SiHxnZ-PcWA:1614321002524&q=%E5%B9%B3%E5%A1%9A+%E7%BE%8E%E5%AE%B9%E9%99%A2&rflfq=1&num=10&sa=X&ved=2ahUKEwiFpKKv9obvAhWBF4gKHei5A5EQjGp6BAgOEFA&biw=1028&bih=506#lrd=0x6019ad24985fadff:0x874520ac70b4b403,1,,,&rlfi=hd:;si:9747232893510661123,l,ChDlubPloZog576O5a656ZmiWiMKCue-juWuuSDpmaIiEeW5s-WhmiDnvo7lrrkg6ZmiKgIIA5IBCmhhaXJfc2Fsb26qARIQASoOIgrnvo7lrrkg6ZmiKAg;mv:[[35.3372193,139.3549256],[35.324571299999995,139.3464819]]')
            d.get('https://www.google.com/search?q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C+%E5%9B%BD%E7%AB%8B&rlz=1C5CHFA_enJP939JP939&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&aqs=chrome..69i57.4119j0j7&sourceid=chrome&ie=UTF-8#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

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
            
            evaluations = []

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
        
            elements.each do |element|
                review_item = element.find_element(:class_name, 'Jtu6Td')
                local_guide = element.find_element(:class_name, 'FGlxyd')
                star_score = element.find_element(:class_name,"PuaHbe").find_element(:class_name,"Fam1ne").attribute('aria-label').scan(/\d+\.\d+?/)[0].to_f
            
                # puts review_item
                # puts local_guide
                # puts star_score
                
                begin
                    review_item.find_element(:css, '.review-more-link').click
                    sleep 0.5
                    content = review_item.find_element(:class_name, 'review-full-text')
                    puts content.text
                    review_count = get_review_count(local_guide)
                    puts review_count
                    puts '問題なし'
                    puts '---------------------------------'
                    # evaluation = Review.new(content.text, review_count, star_score)
                    # evaluations.push(evaluation)
                            
                rescue StandardError
                    puts "なにか問題が発生しました"
                    content = review_item.find_elements(:tag_name, 'span')[0]
                    puts content.text
                    review_count = get_review_count(local_guide)
                    puts review_count
                    puts '---------------------------------'
                #     # evaluation = Review.new(content.text, review_count, star_score)
                #     # evaluations.push(evaluation)
                end
                # # evaluations.each.with_index(1) do |evaluation,index|
                # # puts "-----#{index}番目-----"
                # # puts evaluation.text
                # # puts evaluation.count
                # # puts evaluation.star
                # # end
                # puts 'ok'
            end
        end
    end
end

# class Review
#     attr_reader :text, :count, :star

#     def initialize(text, count, star)
#         @text = text
#         @count = count
#         @star = star
#     end

# end


# class Place
#     attr_reader :place_name, :address
    
#     def initialize(place_name, address)
#         @place_name = place_name
#         @address = address
#     end

# end