class PostController < ApplicationController
    def getAllPost
        if (params[:page])
            pageNum = params[:page]
        else
            pageNum = 1
        end
        if (params[:limit])
            limit = params[:limit]
        else
            limit = 10
        end
        pageNum = pageNum.to_i
        limit = limit.to_i
        pageNum -= 1
        pageNum *= limit
        if (params[:id])
            posts = Post.where(id: params[:id]).offset(pageNum).limit(limit)
        elsif(params[:search])
            posts = Post.where("title like ?", "%#{params[:search]}%").offset(pageNum).limit(limit)
        else
            posts = Post.all.offset(pageNum).limit(limit)
        end
        tags = []
        for i in posts do
                tag = i.attributes
                tag['tag'] = []
                p_tags = Posttag.where(post_id: i.id)
                for j in p_tags do
                    t = Tag.find(j.tag_id)
                    tag['tag'].push(t)
                end
                user = User.find(i.user_id)
                tag['user_name'] = i.attributes
                tag['user_name'] = user
                tag['likes'] = []
                l_like = Like.where(post_id: i.id)
                for j in l_like do
                    l = Like.find(j.id)
                    tag['likes'].push(l)
                end
                tag['count'] = l_like.length
                tags.push(tag)
                # tags.push(like)
        end

        render json: tags
    end
    def getPostByUser
        posts = Post.where(user_id: params[:id])
        tags = []
        for i in posts do
            tag = i.attributes
            tag['tag'] = []
            p_tags = Posttag.where(post_id: i.id)
            for j in p_tags do
                t = Tag.find(j.tag_id)
                tag['tag'].push(t)
            end
            user = User.find(i.user_id)
            tag['user_name'] = i.attributes
            tag['user_name'] = user
            tag['likes'] = []
            l_like = Like.where(post_id: i.id)
            for j in l_like do
                l = Like.find(j.id)
                tag['likes'].push(l)
            end
            tag['count'] = l_like.length
            tags.push(tag)
            # tags.push(like)
        end 
        render json: tags, status: :ok
    end

    skip_before_action :verify_authenticity_token 
    def createPost
        puts("image")
        puts(params[:image])
        params[:image] = params[:image].to_json
        puts("cjekc")
        puts(params)
        tags = params[:tags]
        user = User.find(params[:user_id])
        post = Post.create(params.permit(:parent_id, :title, :content, :image, :publish_date, :status))
        post.user = user
        if (post.save())
            for i in tags do
                if (!Tag.find_by(title: i))
                    t = Tag.create(title: i)
                    t.save
                end
            end
            for i in tags do
                tag = Tag.find_by(title:i)
                posttag = Posttag.create(post: post, tag: tag)
                posttag.save
            end
            render json: "Post Created Successfully", status: :created
        else
            render json: post.errors.full_messages, status: :bad_request
        end
    end
    def updatePost
        params[:image] = params[:image].to_json
        post = Post.find(params[:id]).update(params.permit(:parent_id, :title, :content, :image, :publish_date, :status))
        # puts("user", user.errors.full_messages)
        if (post)
            render json: "Post Created Successfully", status: :created
        else
            render json: "Something went wrong", status: :bad_request
        end
    end
    def deletePost
        post = Post.find(params[:id])
        if (post)
            post.delete
            render json: "Post deleted Successfully", status: :no_content
        else 
            render json: "Something went wrong", status: :bad_request
        end
    end
end
