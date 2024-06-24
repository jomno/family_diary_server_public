require "pdfkit"

class MakePdf
  # PDF 옵션 설정
  def initialize
    options = {
      page_size: "Letter",
      margin_top: "0.25in",
      margin_right: "0.25in",
      margin_bottom: "0.25in",
      margin_left: "0.25in",
    }

    # PDFKit 객체 생성
    pdfkit = PDFKit.new("https://disquiet.io/", options)

    # PDF 파일 생성
    pdfkit.to_file("disquiet.pdf")
  end
end
