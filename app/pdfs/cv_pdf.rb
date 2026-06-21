Prawn::Fonts::AFM.hide_m17n_warning = true

class CvPdf
  BODY_COLOR  = "333333"
  DATE_COLOR  = "666666"
  MUTED_COLOR = "666666"
  TAG_BORDER  = "bbbbbb"
  TAG_TEXT    = "666666"

  def generate
    pdf = Prawn::Document.new(page_size: "A4", margin: [ 80, 72, 80, 72 ])
    pdf.font "Times-Roman"

    header(pdf)
    skills(pdf)
    experience(pdf)
    projects(pdf)
    education(pdf)
    contact(pdf)

    pdf.render
  end

  private

  def header(pdf)
    pdf.font("Times-Italic") { pdf.text "Nathan Jordaan", size: 24 }
    pdf.move_down 14

    years = ((Date.today - Date.parse("2016-01-01")) / 365.25).floor
    pdf.text "Full-stack developer with #{years} years across logistics, mining and fintech. " \
             "Designs, develops and deploys mobile, web, and data systems end-to-end.",
             size: 10, leading: 4, color: BODY_COLOR
    pdf.move_down 16
  end

  def skills(pdf)
    items = [ "SQL", "Ruby on Rails", "C#", ".NET", "Angular", "React", "React Native", "Docker", "Git", "Scrum" ]
    draw_tag_row(pdf, items)
    pdf.move_down 24
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
        pdf.stroke_rounded_rectangle [ x, y ], width, height, 4
        pdf.stroke_color "000000"
        pdf.fill_color TAG_TEXT
        pdf.draw_text text, at: [ x + 5, y - 11 ], size: 8
        pdf.fill_color "000000"

        x += width + 6
      end
    end

    total_height = start_cursor - min_y + line_height
    pdf.move_down(total_height)
  end

  def experience(pdf)
    section(pdf, "Work experience")

    job(pdf,
      company: "ShipShape Software",
      date: "2021 to #{Date.today.year}",
      meta: "SaaS · ERP · Logistics · Hybrid · Johannesburg",
      blurb: "Full development lifecycle — architecture, design, coding, deployment, support, and team management. Delegate work to a small team, manage PRs, and handle production releases directly.",
      bullets: [
        { text: "Redesign and rewrite of a Transport Management (TMS) Android app", tags: [ "React Native", "C#", "MSSQL", "Expo" ] },
        { text: "Redesign and rewrite of existing freight forwarder ERP", tags: [ "Angular", "C#", "MSSQL", "Azure DevOps", "Docker" ] }
      ]
    )

    job(pdf,
      company: "AM² Systems",
      date: "2017 to 2021",
      meta: "Startup · Mining · Petrochem · Hybrid · Johannesburg",
      blurb: "Introduced Scrum and ran company-wide knowledge sharing sessions. Built systems across multiple industries. Designed and implemented multiple applications and modules.",
      bullets: [
        { text: "Industrial data portal — built a C# wrapper around the OSIsoft SDK for web access without direct DB connection", tags: [ "Razor", "C#", "OSIsoft" ] },
        { text: "Fruit export web app with Sage integrations", tags: [ "Razor", "C#", "Sage" ] },
        { text: "Service ingesting Azure IoT streams into Azure Data Explorer", tags: [ "C#", "Azure IoT", "Azure Data Explorer" ] }
      ]
    )

    job(pdf,
      company: "Entelect",
      date: "2016",
      meta: "Contracting · Fintech · Johannesburg",
      blurb: "Delivered features within a structured 2-week scrum team.",
      bullets: [
        { text: "Migrated investment business rules to Drools, working closely with a business analyst", tags: [ "C#", "Java", "Drools" ] },
        { text: "Redesigned the investment approval workflow with the product owner", tags: [ "Process Design" ] }
      ]
    )
  end

  def projects(pdf)
    section(pdf, "Personal Projects")

    y = pdf.cursor
    pdf.text "mysrc", size: 11
    pdf.font("Times-Italic") do
      pdf.fill_color DATE_COLOR
      pdf.text_box "2025",
        at: [ 0, y ],
        width: pdf.bounds.width,
        height: 14,
        size: 9,
        align: :right,
        valign: :center
      pdf.fill_color "000000"
    end
    pdf.move_down 4

    pdf.fill_color BODY_COLOR
    pdf.text_box "Rails app for a recycling company - quotes, shipments, pricing, email lists",
                 at: [ 0, pdf.cursor ],
                 width: pdf.bounds.width,
                 size: 10,
                 leading: 3,
                 overflow: :expand
    pdf.fill_color "000000"
    text_height = pdf.height_of("Rails app for a recycling company - quotes, shipments, pricing, email lists",
                                width: pdf.bounds.width, size: 10, leading: 3)
    pdf.move_down text_height + 4

    pdf.fill_color MUTED_COLOR
    pdf.text_box "Rails · Hotwire · Postgres · Docker",
                 at: [ 0, pdf.cursor ],
                 width: pdf.bounds.width,
                 size: 8,
                 overflow: :expand
    pdf.fill_color "000000"
    pdf.move_down 12
    pdf.move_down 20
  end

  def education(pdf)
    section(pdf, "Education")

    y = pdf.cursor
    pdf.text "University of the Witwatersrand", size: 11
    pdf.font("Times-Italic") do
      pdf.fill_color DATE_COLOR
      pdf.text_box "2012–2015",
        at: [ 0, y ],
        width: pdf.bounds.width,
        height: 14,
        size: 9,
        align: :right,
        valign: :center
      pdf.fill_color "000000"
    end
    pdf.move_down 4
    pdf.text "BSc (Eng) Electrical and Information Engineering", size: 10, color: BODY_COLOR
    pdf.move_down 20
  end

  def contact(pdf)
    pdf.stroke_color "dddddd"
    pdf.line_width 0.5
    pdf.stroke_horizontal_line 0, pdf.bounds.width, at: pdf.cursor
    pdf.move_down 20

    section(pdf, "Contact")

    icon_size = 10
    text_size = 10
    row_height = 10

    pdf.bounding_box([ 0, pdf.cursor ], width: pdf.bounds.width, height: row_height) do
      x = 0
      icon_y = row_height
      text_y = row_height

      pdf.svg File.read("app/assets/svg/icons/lucide/outline/globe.svg"),
              at: [ x, icon_y ],
              width: icon_size,
              height: icon_size,
              color: BODY_COLOR,
              enable_web_requests: false
      x += icon_size + 4

      website_width = pdf.width_of("nathanjordaan.com", size: text_size)
      pdf.formatted_text_box [ { text: "nathanjordaan.com", link: "https://nathanjordaan.com", size: text_size, color: BODY_COLOR } ],
                             at: [ x, text_y ],
                             width: website_width + 4,
                             height: row_height,
                             valign: :center,
                             overflow: :truncate
      x += website_width + 14

      pdf.svg File.read("app/assets/svg/icons/lucide/outline/mail.svg"),
              at: [ x, icon_y ],
              width: icon_size,
              height: icon_size,
              color: BODY_COLOR,
              enable_web_requests: false
      x += icon_size + 4

      email_width = pdf.width_of("nathanjordaan@gmail.com", size: text_size)
      pdf.formatted_text_box [ { text: "nathanjordaan@gmail.com", link: "mailto:nathanjordaan@gmail.com", size: text_size, color: BODY_COLOR } ],
                             at: [ x, text_y ],
                             width: email_width + 4,
                             height: row_height,
                             valign: :center,
                             overflow: :truncate
    end
  end

  def section(pdf, title)
    pdf.font("Times-Italic") { pdf.text title, size: 14 }
    pdf.move_down 12
  end

  def job(pdf, company:, date:, meta:, blurb:, bullets:)
    y = pdf.cursor
    pdf.text company, size: 12
    pdf.font("Times-Italic") do
      pdf.fill_color DATE_COLOR
      pdf.text_box date,
        at: [ 0, y ],
        width: pdf.bounds.width,
        height: 16,
        size: 9,
        align: :right,
        valign: :center
      pdf.fill_color "000000"
    end
    pdf.move_down 4

    pdf.font("Times-Italic") { pdf.text meta, size: 9, color: MUTED_COLOR }
    pdf.move_down 5

    pdf.text blurb, size: 10, leading: 3, color: BODY_COLOR
    pdf.move_down 10

    bullets.each do |bullet|
      bullet_with_inline_tags(pdf, bullet)
    end

    pdf.move_down 14
  end

  def bullet_with_inline_tags(pdf, bullet)
    text = "— #{bullet[:text]}"
    text_width = pdf.width_of(text, size: 10) + 6
    tag_items = bullet[:tags]

    start_cursor = pdf.cursor
    x = pdf.bounds.left
    y = start_cursor
    line_height = 22
    min_y = y

    pdf.fill_color BODY_COLOR
    pdf.draw_text text, at: [ x, y - 11 ], size: 10
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
        pdf.stroke_rounded_rectangle [ x, y ], width, height, 4
        pdf.stroke_color "000000"
        pdf.fill_color TAG_TEXT
        pdf.draw_text tag_text, at: [ x + 5, y - 11 ], size: 8
        pdf.fill_color "000000"

        x += width + 6
      end
    end

    total_height = start_cursor - min_y + line_height
    pdf.move_down(total_height + 4)
  end
end
