class TagController < ApplicationController
    def getPostByTag
        posts = Posttag.where(tag_id: params[:id])
        render json: posts, status: :ok
    end
    def getAllTags 
        tags = Tag.all 
        render json: tags, status: :ok
    end
end
