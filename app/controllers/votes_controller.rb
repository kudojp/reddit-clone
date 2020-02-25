class VotesController < ApplicationController
    def create
        post_id = params[:post_id]
        is_upvote = params[:upvote] == 'true'

        vote =  Vote.new
        vote.post_id = post_id
        vote.account_id = current_account.id
        vote.upvote = is_upvote

        # check if vote by this user exists
        existing_vote = Vote.where( account_id: current_account.id, post_id: post_id )

        respond_to do |format|
            format.js {
                # すでにそのvoteで同じ上下のものが押されている
                if (existing_vote.size > 0) && (existing_vote.first.upvote == is_upvote)
                    existing_vote.destroy_all
                else
                    existing_vote.destroy_all unless existing_vote.nil?
                    @success = false
                    # save new vote
                    if vote.save
                        @success = true
                    end
                end

                @post = Post.find(post_id)
                render "votes/create"
            }
        end
    end

    # private

    # def vote_params
    #     params.require(:vote).permit(:upvote, :post_id)
    # end
end