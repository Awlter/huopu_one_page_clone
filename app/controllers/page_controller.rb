class PageController < ApplicationController
  before_action :set_page_title, only: [:front, :statistics]
  before_action :count_uvs, :count_pvs, only: [:front]
  after_action :save_pvs, only: [:front]

  def front
  end

  def statistics
    @online_users_number = get_online_users_number
    @uvs = UniqueVisitor.count
    @pvs = all_history_pvs

    respond_to do |format|
      format.html {}
      format.js
    end
  end

  private

  def get_online_users_number
    UniqueVisitor.where('updated_at > ?', 1.minutes.ago).count
  end

  def set_page_title
    @page_title = self.class.to_s.gsub('Controller', '')
  end

  def count_uvs
    ip = request.remote_ip
    uv = UniqueVisitor.new(ip: ip)
    UniqueVisitor.find_by(ip: ip).update(updated_at: Time.now) unless uv.save
  end

  def count_pvs
    unless !!read_pvs
      Rails.cache.write(@page_title, all_history_pvs)
    end

    Rails.cache.write(@page_title, read_pvs + 1)
  end

  def read_pvs
    Rails.cache.read(@page_title)
  end

  def all_history_pvs
    PagesViewCount.where(page_title: @page_title).sum("counter")
  end

  def save_pvs
    if more_than_1_secs?
      set_last_time
      if !find_today_view_count
        PagesViewCount.create(page_title: @page_title, date: Time.now.strftime("%F"))
      end
      find_today_view_count.update(counter: read_pvs, date: Time.now.strftime("%F"))
    end
  end

  def find_today_view_count
    PagesViewCount.find_by(page_title: @page_title, date: Time.now.strftime("%F"))
  end

  def more_than_1_secs?
    Time.now - last_time > 1
  end

  def last_time
    unless !!read_last_time
      set_last_time
    end
    read_last_time
  end

  def read_last_time
    Rails.cache.read('last_time')
  end

  def set_last_time
    Rails.cache.write('last_time', Time.now)
  end
end
