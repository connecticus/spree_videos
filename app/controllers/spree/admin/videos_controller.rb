module Spree
  module Admin
    class VideosController < ResourceController
      before_action :load_data
      create.before :set_product
      update.before :set_product

      def update_positions
        params[:positions].each do |id, index|
          Video.update_all(['position=?', index], ['id=?', id])
        end

        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
      end

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
