class LikeController < ApplicationController
    def getUserLikedPost
        user_id = params[:id]
        puts(user_id)
        liked_post = Like.where(user_id: user_id)
        # liked_post = json: liked_post
        posts = []
        for i in liked_post do
            post = Post.find(i.post_id)
            posts.push(post)
        end
        render json: posts, status: :ok
    end
    skip_before_action :verify_authenticity_token 
    def likeDislike
        user_id = params[:user_id]
        post_id = params[:post_id]
        islike = params[:like]
        liketype_id = params[:liketype_id]
        like = Like.find_by(user_id: user_id, post_id: post_id)
        puts(json: like)
        if (!islike) 
            # if (like)
            like = Like.find_by(user_id: user_id, post_id: post_id)
            if (like)
                like.delete
            end
            render json: "Disliked", status: :created
        else 
            user = User.find(user_id)
            post = Post.find(post_id)
            puts(user, post)

            # isLike = Like.find_by(user_id: user_id, post_id: post_id)
            like_al = Like.find_by(user_id: user_id, post_id: post_id)
            like = Like.new(user: user, post: post, liketype_id: liketype_id)
            if (!like_al && islike && like.save)
                render json: "Liked", status: :created
            else
                render json: post.errors.full_messages, status: :bad_request
            end
        end
    end
end
