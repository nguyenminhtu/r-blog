require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class Post < ApplicationRecord

    mount_uploader :image, ImageUploader

    extend FriendlyId
    friendly_id :title, use: :slugged


    belongs_to :author
    has_many :comments, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true
    validates :body, presence: true

    scope :most_recent, -> { order(created_at: :desc) }

    scope :get_all, -> (page, per_page) { most_recent.paginate(:page => page, :per_page => per_page) }

    scope :find_by_friendly, -> (id) { friendly.find(id) }

    def should_generate_new_friendly_id?
        title_changed?
    end

    def display_created_at
        "#{created_at.strftime('%-b %-d, %Y')}"
    end

    def time_ago
        "#{time_ago_in_words(created_at)} ago"
    end

end
