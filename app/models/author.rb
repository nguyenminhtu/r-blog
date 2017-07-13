class Author < ApplicationRecord

    mount_uploader :avatar, AvatarUploader

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    def gravatar_hash
        Digest::MD5.hexdigest(email)
    end

    def gravatar_image_url
        unless avatar.to_s.empty?
            "#{avatar}"
        else
            "https://www.gravatar.com/avatar/#{gravatar_hash}"
        end
    end

end
