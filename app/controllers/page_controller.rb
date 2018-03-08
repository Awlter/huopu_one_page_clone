class PageController < ApplicationController
  before_action :set_page_title, :count_uvs, :count_pvs, only: [:front]
  after_action :save_pvs

  def front
  end

  private

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
      Rails.cache.write(@page_title, PagesViewCount.find_by(page_title: @page_title).counter)
    end

    Rails.cache.write(@page_title, read_pvs + 1)
  end

  def read_pvs
    Rails.cache.read(@page_title)
  end

  def save_pvs
    if more_than_1_secs?
      set_last_time
      PagesViewCount.find_by(page_title: @page_title).update(counter: read_pvs)
    end
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
