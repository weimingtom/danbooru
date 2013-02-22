module Moderator
  module Post
    class QueuesController < ApplicationController
      respond_to :html, :json
      before_filter :janitor_only
      
      def show
        ::Post.without_timeout do
          @posts = ::Post.order("id asc").pending_or_flagged.available_for_moderation(params[:hidden]).search(:tag_match => "#{params[:query]} status:any").paginate(params[:page])
        end
        respond_with(@posts)
      end
    end
  end
end
