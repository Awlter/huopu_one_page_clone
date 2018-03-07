class PageController < ApplicationController
  before_action :add_uv

  def front
  end

  private

  def add_uv
    ip = request.remote_ip
    uv = UniqueVisitor.new(ip: ip)
    UniqueVisitor.find_by(ip: ip).update(updated_at: Time.now) unless uv.save
  end
end
