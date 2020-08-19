module Spree
  module Admin
    class VideosController < ResourceController
      before_action :load_data
      create.before :set_product
      update.before :set_product



      private
  
      def location_after_save
        if @product
          admin_product_videos_url(@product)
        else
          admin_videos_url
        end
      end

      def location_after_destroy
        if @product
          admin_product_videos_url(@product)
        else
          admin_videos_url
        end
      end

      def load_data
        @product = Product.find_by(slug: params[:product_id] || (params[:video] && params[:video][:product_id]))
      end

      def set_product
        @video.watchable = @product
      end
    end
  end
end
