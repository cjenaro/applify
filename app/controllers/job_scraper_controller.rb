class JobScraperController < ApplicationController
  require "open-uri"
  require "nokogiri"
  require "openai"

  def scrape
    url = params[:url]
    return render turbo_stream: turbo_stream.replace("job-details", partial: "job_scraper/error", locals: { message: "Invalid URL" }) unless url.present?

    begin
      # Fetch the page content
      html = URI.open(url).read

      openai_api_key = Rails.application.credentials.dig(:openai, :api_key);
      client = OpenAI::Client.new(access_token: openai_api_key)

      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          response_format: { type: "json_object" },
          messages: [
            { role: "system", content: 
                "You are an expert job details extractor."\
                "Extract the job title, company name, and job description from the following HTML content."\
                "Always reply with JSON { job_title: string, company_name: string, job_description: string }, Do NOT use html or markdown in any of the fields."\
                "Take into account that a lot of the urls might be to ATS like ashby, greenhouse or lever which might "\
                "have the page title of a recruiting company but the job might be for a different company, so read "\
                "the whole HTML to find out the final company name, it might not be at the beginning of the page." 
            },
            { role: "user", content: html }
          ]
        }
      )

      # Parse OpenAI's response
      parsed_response = JSON.parse(response.to_json)
      details = JSON.parse(parsed_response.dig("choices", 0, "message", "content"))

      job_title = details["job_title"]
      company_name = details["company_name"]
      job_description = details["job_description"]

      application = Application.new(
        position: job_title,
        company: company_name,
        description: job_description,
        position_url: params[:url]
      )

      render turbo_stream: turbo_stream.replace(
        "application-form",
        partial: "applications/form",
        locals: { application: application }
      )
    rescue => e
      render turbo_stream: turbo_stream.replace("job-details", partial: "job_scraper/error", locals: { message: e.message })
    end
  end
end
