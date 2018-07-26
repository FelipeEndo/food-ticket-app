module EmployeesHelper
  def older_employees(file)
    file[1..file.count].select { |row| more_than_one_year? Date.strptime(row[3], "%d-%m-%y")}
  end
  
  def newer_employees(file)
    file[1..file.count].reject { |row| more_than_one_year? Date.strptime(row[3], "%d-%m-%y")}
  end

  def more_than_one_year?(date)
    Date.today - date > 365
  end
  
  def replace_name_and_surname(file)
    file.each_with_index do |line, index|
      if index > 0
        line[0] = [line[0], line[1]].join(' ')
      end
      line.delete_at(1)
    end
  end
end