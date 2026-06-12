Prawn::Fonts::AFM.hide_m17n_warning = true

class CvPdf
  BODY_COLOR  = "333333"
  DATE_COLOR  = "666666"
  MUTED_COLOR = "666666"
  TAG_BORDER  = "bbbbbb"
  TAG_TEXT    = "666666"

  def initialize(cv)
    @cv = cv
  end

  def generate
    pdf = Prawn::Document.new(page_size: "A4", margin: [80, 72, 80, 72])
    pdf.font "Times-Roman"

    header(pdf)
    skills(pdf)
    sections(pdf)
    contact(pdf) if @cv.email == "nathanjordaan@gmail.com"

    pdf.render
  end

  private

  def header(pdf)
    pdf.font("Times-Italic") { pdf.text @cv.name, size: 24 }
    pdf.move_down 14

    pdf.text @cv.summary, size: 10, leading: 4, color: BODY_COLOR
    pdf.move_down 16
  end

  def skills(pdf)
    items = @cv.tags.map(&:name)
    draw_tag_row(pdf, items)
    pdf.move_down 24
  end

  def sections(pdf)
    @cv.sections.each do |section|
      pdf.font("Times-Italic") { pdf.text section.title, size: 14 }
      pdf.move_down 12

      section.entries.each do |entry|
        render_entry(pdf, entry, section.title)
      end
    end
  end

  def render_entry(pdf, entry, section_title)
    y = pdf.cursor
    pdf.text entry.title, size: 12

    if entry.date_text.present?
      pdf.font("Times-Italic") do
        pdf.fill_color DATE_COLOR
        pdf.text_box entry.date_text,
          at: [0, y],
          width: pdf.bounds.width,
          height: 16,
          size: 9,
          align: :right,
          valign: :center
        pdf.fill_color "000000"
      end
    end
    pdf.move_down 4

    if entry.meta.present?
      pdf.font("Times-Italic") { pdf.text entry.meta, size: 9, color: MUTED_COLOR }
      pdf.move_down 5
    end

    if entry.blurb.present?
      tag_items = entry.tags.map(&:name)
      if tag_items.any? && entry.subtitle.blank?
        entry_with_inline_tags(pdf, entry.blurb, tag_items)
      else
        pdf.text entry.blurb, size: 10, leading: 3, color: BODY_COLOR
        pdf.move_down 10
      end
    end

    if entry.subtitle.present?
      entry_with_inline_tags(pdf, entry.subtitle, entry.tags.map(&:name))
    end

    entry.bullets.each do |bullet|
      bullet_with_inline_tags(pdf, bullet)
    end

    pdf.move_down 14
  end

  def draw_tag_row(pdf, items)
    return if items.empty?

    start_cursor = pdf.cursor
    x = pdf.bounds.left
    y = start_cursor
    line_height = 22
    min_y = y

    pdf.font("Times-Italic") do
      items.each do |item|
        text = item.to_s
        width = pdf.width_of(text, size: 8) + 10
        height = 16

        if x + width > pdf.bounds.right
          x = pdf.bounds.left
          y -= line_height
          min_y = y
        end

        pdf.stroke_color TAG_BORDER
        pdf.line_width 0.5
        pdf.stroke_rounded_rectangle [x, y], width, height, 4
        pdf.stroke_color "000000"
        pdf.fill_color TAG_TEXT
        pdf.draw_text text, at: [x + 5, y - 11], size: 8
        pdf.fill_color "000000"

        x += width + 6
      end
    end

    total_height = start_cursor - min_y + line_height
    pdf.move_down(total_height)
  end

  def entry_with_inline_tags(pdf, subtitle, tag_items)
    text_width = pdf.width_of(subtitle, size: 10) + 6

    start_cursor = pdf.cursor
    x = pdf.bounds.left
    y = start_cursor
    line_height = 22
    min_y = y

    pdf.fill_color BODY_COLOR
    pdf.draw_text subtitle, at: [x, y - 11], size: 10
    pdf.fill_color "000000"
    x += text_width

    pdf.font("Times-Italic") do
      tag_items.each do |item|
        tag_text = item.to_s
        width = pdf.width_of(tag_text, size: 8) + 10
        height = 16

        if x + width > pdf.bounds.right
          x = pdf.bounds.left
          y -= line_height
          min_y = y
        end

        pdf.stroke_color TAG_BORDER
        pdf.line_width 0.5
        pdf.stroke_rounded_rectangle [x, y], width, height, 4
        pdf.stroke_color "000000"
        pdf.fill_color TAG_TEXT
        pdf.draw_text tag_text, at: [x + 5, y - 11], size: 8
        pdf.fill_color "000000"

        x += width + 6
      end
    end

    total_height = start_cursor - min_y + line_height
    pdf.move_down(total_height + 4)
  end

  def bullet_with_inline_tags(pdf, bullet)
    text = "- #{bullet.description}"
    text_width = pdf.width_of(text, size: 10) + 6
    tag_items = bullet.tags.map(&:name)

    start_cursor = pdf.cursor
    x = pdf.bounds.left
    y = start_cursor
    line_height = 22
    min_y = y

    pdf.fill_color BODY_COLOR
    pdf.draw_text text, at: [x, y - 11], size: 10
    pdf.fill_color "000000"
    x += text_width

    pdf.font("Times-Italic") do
      tag_items.each do |item|
        tag_text = item.to_s
        width = pdf.width_of(tag_text, size: 8) + 10
        height = 16

        if x + width > pdf.bounds.right
          x = pdf.bounds.left + 10
          y -= line_height
          min_y = y
        end

        pdf.stroke_color TAG_BORDER
        pdf.line_width 0.5
        pdf.stroke_rounded_rectangle [x, y], width, height, 4
        pdf.stroke_color "000000"
        pdf.fill_color TAG_TEXT
        pdf.draw_text tag_text, at: [x + 5, y - 11], size: 8
        pdf.fill_color "000000"

        x += width + 6
      end
    end

    total_height = start_cursor - min_y + line_height
    pdf.move_down(total_height + 4)
  end

  def contact(pdf)
    pdf.stroke_color "dddddd"
    pdf.line_width 0.5
    pdf.stroke_horizontal_line 0, pdf.bounds.width, at: pdf.cursor
    pdf.move_down 20

    pdf.font("Times-Italic") { pdf.text "Contact", size: 14 }
    pdf.move_down 12

    icon_size = 10
    text_size = 10
    row_height = 10

    pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width, height: row_height) do
      x = 0
      icon_y = row_height
      text_y = row_height

      pdf.svg File.read("app/assets/svg/icons/lucide/outline/globe.svg"),
              at: [x, icon_y],
              width: icon_size,
              height: icon_size,
              color: BODY_COLOR,
              enable_web_requests: false
      x += icon_size + 4

      website = @cv.website_url.to_s.sub(%r{^https?://}, "")
      website_width = pdf.width_of(website, size: text_size)
      pdf.formatted_text_box [{ text: website, link: @cv.website_url, size: text_size, color: BODY_COLOR }],
                             at: [x, text_y],
                             width: website_width + 4,
                             height: row_height,
                             valign: :center,
                             overflow: :truncate
      x += website_width + 14

      pdf.svg File.read("app/assets/svg/icons/lucide/outline/mail.svg"),
              at: [x, icon_y],
              width: icon_size,
              height: icon_size,
              color: BODY_COLOR,
              enable_web_requests: false
      x += icon_size + 4

      email_width = pdf.width_of(@cv.email, size: text_size)
      pdf.formatted_text_box [{ text: @cv.email, link: "mailto:#{@cv.email}", size: text_size, color: BODY_COLOR }],
                             at: [x, text_y],
                             width: email_width + 4,
                             height: row_height,
                             valign: :center,
                             overflow: :truncate
    end
  end
end
