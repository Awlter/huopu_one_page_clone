class PageController < ApplicationController
  before_action :set_and_add_uvs, :set_and_add_pvs

  def front

  end

  private

  def set_and_add_uvs
    ip = request.remote_ip
    uv = UniqueVisitor.new(ip: ip)
    UniqueVisitor.find_by(ip: ip).update(updated_at: Time.now) unless uv.save
    @uvs = UniqueVisitor.count
  end

  def set_and_add_pvs
    page_title = self.class.to_s.gsub('Controller', '')
    @pvs = Rails.cache.read(page_title) || Rails.cache.write(page_title, PagesViewCount.find_by(page_title: page_title).counter)

    Rails.cache.write(page_title, @pvs + 1)
  end
end
