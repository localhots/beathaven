class User < ActiveRecord::Base
  attr_accessible :lang, :name, :vk_id

  def dump_json
    Jbuilder.encode do |j|
      j.id id
      j.name name
      j.lang lang
      j.vk_id vk_id
    end
  end
end
