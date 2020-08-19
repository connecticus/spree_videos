module Spree
  class Video < ActiveRecord::Base
    acts_as_list scope: :watchable

    belongs_to :watchable, :polymorphic => true, :touch => true

    attr_accessor :product_id
    validates_presence_of :youtube_ref
    validates_uniqueness_of :youtube_ref, :scope => [:watchable_id, :watchable_type]

    scope :show_on_home_videos, -> { where show_on_home: true }
    scope :streams, -> { where stream: true }
    scope :stream_or_home_videos, -> { where('stream = true OR show_on_home = true') }

    def youtube_data
      begin
        youtube_data = Yt::Models::Video.new(id: youtube_ref)
        youtube_data.title # check for api errors
        youtube_data
      rescue Yt::Errors::NoItems
        OpenStruct.new(
            id: youtube_ref,
            title: 'Video has been deleted',
            description: '',
            thumbnail_url: (URI.join(Spree::Core::Engine.routes.url_helpers.root_url, "assets/thumb_not_found.png").to_s rescue '/assets/thumb_not_found.png'),
            duration: 0,
            views: 0,
            embed_html: ''
        )
      end
    end

    def youtube_link
      "https://www.youtube.com/watch?v=#{youtube_ref}"
    end

    def embed_html(html5_config = {}, youtube_url_params = {})
      if youtube_url_params.empty?
        youtube_data.embed_html
      else
        youtube_data.embed_html.sub(youtube_data.id, "#{youtube_data.id}?#{youtube_url_params.map{|k,v| "#{k}=#{v}"}.join('&')}")
      end
    end

    after_validation do
      youtube_ref.match(/(v=|\/)([\w-]+)(&.+)?$/) { |m| self.youtube_ref = m[2] }
      video_data_update
    end

    def video_data_update
      video = Yt::Video.new(id: youtube_ref)
      begin
        self.title        =  video.title unless self.title_changed?
        self.description  =  video.description
        self.duration     =  video.duration
        self.likes        =  video.like_count
        self.dislikes     =  video.dislike_count
        self.comments     =  video.comment_count
        self.views        =  video.view_count
        self.subscribers  =  video.favorite_count
        self.thumbnail_url = video.thumbnail_url
      rescue
      end
    end
  end
end
