module ApplicationHelper

    def profile_image(user)
        image_tag("space11.jpeg", alt: user.username, class: "rounded mx-auto d-block w-25")
    end


end
