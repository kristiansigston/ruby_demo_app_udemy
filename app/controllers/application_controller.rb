class ApplicationController < ActionController::Base
  def gravatar_for(user)
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}"
    image_tag(gravatar_url, alt: user.username)
  end

  def random_image_for(options)
    url = "<img src='https://source.unsplash.com/random/200x200' />"
    url
  end
end
