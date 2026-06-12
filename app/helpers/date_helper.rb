module DateHelper
  def months_between(date1, date2)
    return 0 if date1.nil? || date2.nil?

    d1 = date1.to_date
    d2 = date2.to_date

    months = (d2.year * 12 + d2.month) - (d1.year * 12 + d1.month)
    months -= 1 if d2.day < d1.day
  end

  def years_between(date1, date2)
    return 0 if date1.nil? || date2.nil?

    months_between(date1, date2) / 12
  end
end
