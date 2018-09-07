module Scrapper
    extend ActiveSupport::Concern
    require 'nokogiri'
    require 'open-uri'

    ##CALL ORDER TO GET DB UP TO DATE 

    ##Company
    ##Model Line
    ##Coaster Model
    ##Park
    ##Coaster

    def scrap_company
        i = 1
        while(i < 15)
            url = "https://rcdb.com/r.htm?ot=12&page=#{i}"
            doc = Nokogiri::HTML(open(url))
            entries = doc.css('#report')
            entries.css('tbody')[0].css('tr').each do |entry|
                nodeset = entry.css('a[href]')    # Get anchors w href attribute via css
                nodeset.map {|element| 
                    id = element["href"].slice(1..(element["href"].index('.')-1))
                    does_company_exist = Company.find_by_api_id(id)
                    if !does_company_exist
                        company_html = Nokogiri::HTML(open("https://rcdb.com/#{id}.htm"))
                        company_info = company_html.css('#feature')
                        name = company_info.css('h1').text
                        location_info = company_info.css('.scroll')[0]
                        location_links = location_info.css("a[href]")
                        location_text = ""
                        location_links.map {|link|
                            if location_text.length > 0 
                                location_text = location_text + ', ' + link.text
                            else
                                location_text = link.text
                            end
                        }
                        possible_status = location_info.next_element.next_element.text
                        if possible_status
                            Company.create!(api_id: id, name: name, location: location_text, status: possible_status)
                        else
                            Company.create!(api_id: id, name: name, location: location_text, status: "Defunct")
                        end
                    end
                    

                }
            end
            i = i + 1
        end
    end

    def scrap_model_line
        i = 1
        while(i < 15)
            url = "https://rcdb.com/r.htm?ot=6&page=#{i}"
            doc = Nokogiri::HTML(open(url))
            entries = doc.css('#report')
            entries.css('tbody')[0].css('tr').each do |entry|
                nodeset = entry.css('a[href]')    # Get anchors w href attribute via css
                id = nodeset[0]["href"].slice(1..(nodeset[0]["href"].index('.')-1))
                company_id = nodeset[1]["href"].slice(1..(nodeset[1]["href"].index('.')-1))
                name = nodeset[0].text
                does_line_exist = ModelLine.find_by_api_id(id)
                if !does_line_exist
                    ModelLine.create!(api_id: id, name: name, company_id: Company.find_by_api_id(company_id) ? Company.find_by_api_id(company_id).id : nil)
                end
            end
            i = i + 1
        end
    end

    def scrap_coaster_model
        i = 1
        while(i < 29)
            url = "https://rcdb.com/r.htm?ot=5&page=#{i}"
            doc = Nokogiri::HTML(open(url))
            entries = doc.css('#report')
            entries.css('tbody')[0].css('tr').each do |entry|
                nodeset = entry.css('a[href]')    # Get anchors w href attribute via css
                id = nodeset[0]["href"].slice(1..(nodeset[0]["href"].index('.')-1))
                model_id = nodeset[1]["href"].slice(1..(nodeset[1]["href"].index('.')-1))
                company_id = nodeset[2]["href"].slice(1..(nodeset[1]["href"].index('.')-1))
                name = nodeset[0].text
                does_line_exist = CoasterModel.find_by_api_id(id)
                if !does_line_exist
                    CoasterModel.create!(api_id: id, name: name, company_id: Company.find_by_api_id(company_id) ? Company.find_by_api_id(company_id).id : nil, model_line_id: ModelLine.find_by_api_id(model_id) ? ModelLine.find_by_api_id(model_id).id : nil)
                end
            end
            i = i + 1
        end
    end

    def scrap_coaster
        i = 1
        while(i < 387)
            url = "https://rcdb.com/r.htm?ot=2&page=#{i}"
            doc = Nokogiri::HTML(open(url))
            entries = doc.css('#report')
            entries.css('tbody')[0].css('tr').each do |entry|
                nodeset = entry.css('td')
                link_name = nodeset[1].css('a[href]')
                park_link = nodeset[2].css('a[href]')
                id = link_name[0]["href"].slice(1..(link_name[0]["href"].index('.')-1))
                name = link_name[0].text
                park_id = park_link[0]["href"].slice(1..(park_link[0]["href"].index('.')-1))
                coaster_type = nodeset[3].text
                coaster_design = nodeset[4].text
                status = nodeset[5].text
                opened = nodeset[6].text
                coaster_html = Nokogiri::HTML(open("https://rcdb.com/#{id}.htm")) 
                website_url = coaster_html.css('#media_row')
                website_link = ''
                lat = nil
                long = nil
                maps = coaster_html.css('#popMaps')
                maps.css('div').each do |map|
                    if lat.nil? && long.nil?
                        if map.css('a[href]')[0]["data-background"] == "/40.svg"
                            google_array = map.css('a[href]')[0]["href"].split('/') 
                            map_coords = google_array[5].split(',')
                            if map_coords.length > 0
                                lat = map_coords[0]
                                long = map_coords[1]
                            end
                        end
                    else
                    end
                end
                does_coaster_exist = Coaster.find_by_api_id(id)
                if !does_coaster_exist
                   does_coaster_exist = Coaster.create!(api_id: id,park_id: Park.find_by_api_id(park_id).id, name: name, coaster_type: coaster_type, coaster_design: coaster_design , status: status, opened: opened, lat: lat, long: long)
                end
                scroll_two = coaster_html.css('.scroll')
                make_model_text = scroll_two[1].text
                if make_model_text.include?("Make") && make_model_text.include?("Model")
                    make_links = scroll_two[1].css('a[href]')
                    maker_id = make_links[0]["href"].slice(1..(make_links[0]["href"].index('.')-1))
                    does_maker_exist = CoasterCompany.where(coaster_id: does_coaster_exist.id, company_id: Company.find_by_api_id(maker_id).id).first
                    if does_maker_exist.nil?
                        CoasterCompany.create!(coaster_id: does_coaster_exist.id, company_id: Company.find_by_api_id(maker_id).id)
                    end
                    j = 1
                    while(j < make_links.length)
                        model_id = make_links[j]["href"].slice(1..(make_links[j]["href"].index('.')-1))
                        coaster_model_found = CoasterModel.find_by_api_id(model_id)
                        if coaster_model_found
                            does_model_exist = CoasterModelType.where(coaster_id: does_coaster_exist.id, coaster_model_id: CoasterModel.find_by_api_id(model_id).id).first
                            if does_model_exist.nil?
                                CoasterModelType.create!(coaster_id: does_coaster_exist.id, coaster_model_id: CoasterModel.find_by_api_id(model_id).id)
                            end
                        end
                        j = j + 1
                    end
                elsif make_model_text.include?("Make") && !make_model_text.include?("Model")
                    make_links = scroll_two[1].css('a[href]')
                    maker_id = make_links[0]["href"].slice(1..(make_links[0]["href"].index('.')-1))
                    does_maker_exist = CoasterCompany.where(coaster_id: does_coaster_exist.id, company_id: Company.find_by_api_id(maker_id).id).first
                    if does_maker_exist.nil?
                        CoasterCompany.create!(coaster_id: does_coaster_exist.id, company_id: Company.find_by_api_id(maker_id).id)
                    end
                elsif make_model_text.include?("Model") && !make_model_text.include?("Make")
                    make_links = scroll_two[1].css('a[href]')
                    j = 0
                    while(j < make_links.length)
                        model_id = make_links[j]["href"].slice(1..(make_links[j]["href"].index('.')-1))
                        coaster_model_found = CoasterModel.find_by_api_id(model_id)
                        if coaster_model_found
                            does_model_exist = CoasterModelType.where(coaster_id: does_coaster_exist.id, coaster_model_id: CoasterModel.find_by_api_id(model_id).id).first
                            if does_model_exist.nil? && CoasterModel.find_by_api_id(model_id).exist?
                                CoasterModelType.create!(coaster_id: does_coaster_exist.id, coaster_model_id: CoasterModel.find_by_api_id(model_id).id)
                            end
                        end
                        j = j + 1
                    end
                end
            end
            i = i + 1
        end
    end

    def scrap_park
        i = 1
        while(i < 187)
            url = "https://rcdb.com/r.htm?ot=3&page=#{i}"
            doc = Nokogiri::HTML(open(url))
            entries = doc.css('#report')
            entries.css('tbody')[0].css('tr').each do |entry|
                nodeset = entry.css('td')    # Get anchors w href attribute via css
                #id = nodeset[1]["href"].slice(1..(nodeset[1]["href"].index('.')-1))
                link_name = nodeset[1].css('a[href]')
                id = link_name[0]["href"].slice(1..(link_name[0]["href"].index('.')-1))
                name = link_name[0].text
                location = nodeset[2].text
                status = nodeset[3].text
                open_date = nodeset[4].text
                park_html = Nokogiri::HTML(open("https://rcdb.com/#{id}.htm"))
                website_url = park_html.css('#media_row')
                website_link = ''
                lat = nil
                long = nil
                if website_url
                    website_url.css('a').each do |link|
                        if link["data-background"] == "/27.svg"
                            website_link = link["href"]
                        end
                    end
                end
                maps = park_html.css('#popMaps')
                maps.css('div').each do |map|
                    if lat.nil? && long.nil?
                        if map.css('a[href]')[0]["data-background"] == "/40.svg"
                            google_array = map.css('a[href]')[0]["href"].split('/') 
                            map_coords = google_array[5].split(',')
                            if map_coords.length > 0
                                lat = map_coords[0]
                                long = map_coords[1]
                            end
                        end
                    else
                    end
                end
                does_park_exist = Park.find_by_api_id(id)
                if !does_park_exist
                    Park.create!(api_id: id, name: name, location: location, status: status, open_date: open_date, website_url: website_link, lat: lat, long: long)
                end
                #location_name = nodeset[1].text
            end
            i = i + 1
        end
    end


    def area_builder
        Park.all.each do |park|
            count = park.location.count(',')
            location_array = park.location.split(',')
            if count == 2
                park.country = location_array[2].strip
                park.state = location_array[1].strip
                park.city = location_array[0].strip
            elsif count == 3
                park.country = location_array[3].strip
                park.state = location_array[2].strip
                park.county = location_array[1].strip
                park.city = location_array[0].strip
            elsif count == 4
                park.country = location_array[4].strip
                park.state = location_array[3].strip
                park.county = location_array[2].strip
                park.district = location_array[1].strip
                park.city = location_array[0].strip
            elsif count == 1
                park.country = location_array[1].strip
                park.city = location_array[0].strip
            else
                puts "HELP"
                puts count
                puts park.id
            end
            park.save
        end

    end
end