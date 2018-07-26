module DataFilesHelper
  def older_employees(file)
    file[1..file.count].select { |row| more_than_one_year? Date.strptime(row[3], "%d-%m-%y")}
  end
  
  def newer_employees(file)
    file[1..file.count].reject { |row| more_than_one_year? Date.strptime(row[3], "%d-%m-%y")}
  end

  def more_than_one_year?(date)
    Date.today - date > 365
  end

end
