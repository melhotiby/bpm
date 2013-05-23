namespace :load do
  
  require 'csv'

  desc "Import users with a CSV file"
  task(:import_users, [:file] => :environment) do |t,args|
    imported_users = 0
    CSV.foreach(args[:file], :headers => true) do |row|
      unless row.nil?
        imported_users += 1
        user = User.new username:     row['Username'], 
                        age:          row['Age'],
                        gender:       row['Gender'],
                        hr_zone1_min: row['HR Zone1 BPM Min'],
                        hr_zone1_max: row['HR Zone1 BPM Max'],
                        hr_zone2_min: row['HR Zone2 BPM Min'],
                        hr_zone2_max: row['HR Zone2 BPM Max'],
                        hr_zone3_min: row['HR Zone3 BPM Min'],
                        hr_zone3_max: row['HR Zone3 BPM Max'],
                        hr_zone4_min: row['HR Zone4 BPM Min'],
                        hr_zone4_max: row['HR Zone4 BPM Max']
        user.save

        # this is needed to ensure the id matches the CSV
        sql = "update users set id=#{row['User ID']} where id=#{user.id}"
        ActiveRecord::Base.connection.execute(sql)

      end
    end
    puts "#{imported_users} users imported!"
  end

  desc "Import HRM Data with a CSV file"
  task(:import_hrm_data, [:file] => :environment) do |t,args|
    imported_hrm_data = 0
    CSV.foreach(args[:file], :headers => true) do |row|
      unless row.nil?
        imported_hrm_data += 1
        HrmDataPoint.create session_id:         row['Session ID'], 
                       bpm:                row['Beats Per Minute'],
                       reading_start_time: row['Reading Start Time'],
                       reading_end_time:   row['Reading End Time'],
                       duration:           row['Duration in Secs']

      end
    end
    puts "#{imported_hrm_data} HRM Data imported!"
  end

  desc "Import Session Data with a CSV file"
  task(:import_session, [:file] => :environment) do |t,args|
    import_session_data = 0
    CSV.foreach(args[:file], :headers => true) do |row|
      unless row.nil?
        import_session_data += 1
        session = Session.new user_id:    row['User Id'],
                              created_at: row['Created At'],
                              duration:   row['Duration in Secs']
        session.save

        # this is needed to ensure the id matches the CSV
        sql = "update sessions set id=#{row['Session ID']} where id=#{session.id}"
        ActiveRecord::Base.connection.execute(sql)

      end
    end
    puts "#{import_session_data} Sessions imported!"
  end


  desc "add Caluculations"
  task :add_caluculations => :environment do
    Session.order('id asc').each do |session|
      calulation = session.build_calculation
      calulation.min_bpm = session.minimum_bpm
      calulation.max_bpm = session.maximum_bpm
      calulation.average_bpm = session.avg_bpm
      calulation.zone1_duration = session.zone1_total_duration
      calulation.zone2_duration = session.zone2_total_duration
      calulation.zone3_duration = session.zone3_total_duration
      calulation.zone4_duration = session.zone4_total_duration
      calulation.save
    end
    puts "Caluculations added!"
  end

end
