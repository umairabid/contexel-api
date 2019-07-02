class StatsController < ApplicationController

  def index
    htmlStrippedContent = ActionController::Base.helpers.strip_tags(params[:html])
    mistakes = HTTP.post('https://service.afterthedeadline.com/checkDocument', :form => {
      :key => "6cbf04091ca08baddbacb414764774a7",
      :data => htmlStrippedContent
    })


=begin
    plagarism_req_body = HTTP.post('https://www.prepostseo.com/apis/checkPlag', :form => {
        :key => "15c0bf29109451a8dab9d47226465b7c",
        :data => htmlStrippedContent
    }).body

    plagarism = JSON.parse(plagarism_req_body)
=end

    plagarism = JSON.parse File.read(Rails.root.join('public/plag-test.json'))
    render json: {
        mistakes: Hash.from_xml(mistakes.body),
        plagarism: plagarism
    }
  end

end