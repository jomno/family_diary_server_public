require "base64"
require "httparty"
require "uri"

class EpsonPrinter
  attr_accessor :printer_email

  BASE_URI = Rails.application.credentials.dig(:EPSON_BASE_URI)
  CLIENT_ID = Rails.application.credentials.dig(:EPSON_CONNECT_CLIENT_ID)
  SECRET_KEY = Rails.application.credentials.dig(:EPSON_CONNECT_SECRET_KEY)

  def initialize(printer_email: "family_diary@print.epsonconnect.com")
    @printer_email = printer_email
  end

  def authenticate!
    encoded_string = "#{CLIENT_ID}:#{SECRET_KEY}"
    auth_code = Base64.strict_encode64(encoded_string)

    query_params = {
      grant_type: "password",
      username: @printer_email,
      password: "",
    }

    response = HTTParty.post(
      auth_uri,
      body: URI.encode_www_form(query_params),
      headers: {
        "Authorization" => "Basic #{auth_code}",
        "Content-Type" => "application/x-www-form-urlencoded; charset=utf-8",
      },
    )

    if response.code != 200
      if response["error"] == "invalid_grant"
        raise "유효하지 않은 프린터 이메일이나, 인쇄 설정에서 원격인쇄를 허가하지 않았습니다."
      else
        raise "인증에 실패했습니다. 다시 시도해주세요."
      end
    end

    @access_token = response["access_token"]
    @refresh_token = response["refresh_token"]
    @device_id = response["subject_id"]
  end

  def get_job
    data = {
      "job_name" => "SampleJob1",
      "print_mode" => "document",
      "print_setting" => {
        "media_size" => "ms_a4",
        "media_type" => "mt_plainpaper",
        "borderless" => false,
        "print_quality" => "normal", # "draft", "normal", "high"
        "source" => "auto",
        "color_mode" => "color",
        "reverse_order" => true,
        "copies" => 1,
        "collate" => false,
      },
    }
    response = HTTParty.post(job_uri, body: data.to_json, headers: { "Authorization" => "Bearer #{@access_token}", "Content-Type" => "application/json; charset=utf-8" })

    @job_id = response["id"]
    @upload_uri = response["upload_uri"]
  end

  def upload_file_from_url(url)
    path = "#{@upload_uri}&File=1.pdf"
    response = HTTParty.post(path, body: URI.open(url).read, headers: { "Authorization" => "Bearer #{@access_token}", "Content-Type" => "application/octet-stream", "Content-Length" => URI.open(url).size.to_s })
  end

  def print
    print_uri = "#{BASE_URI}/printers/#{@device_id}/jobs/#{@job_id}/print"
    response = HTTParty.post(print_uri, headers: { "Authorization " => "Bearer #{@access_token}", "Content-Type" => "application/json; charset=utf-8" })
  end

  private

  def auth_uri
    "#{BASE_URI}/oauth2/auth/token?subject=printer"
  end

  def job_uri
    "#{BASE_URI}/printers/#{@device_id}/jobs"
  end
end
