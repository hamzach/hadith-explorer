class ConversationsController < ApplicationController
	def index
  		if session[:user_type] == "scholar" && params[:target_id] == nil
  			@scholars = User.where("id != ? AND usertype = ?", session[:user_id], 'scholar')
  		elsif session[:user_type] == "scholar" && params[:target_id] != nil
        @scholars = User.where("id != ? AND usertype = ?", session[:user_id], 'scholar')
        conversation = Conversation.where("starter = ? AND target = ?", session[:user_id], params[:target_id]).take
        if conversation == nil
          conversation = Conversation.where("starter = ? AND target = ?", params[:target_id], session[:user_id]).take
        end
        if conversation.starter == session[:user_id]
          @second_scholar = User.where("id = ?", conversation.target).take
        else
          @second_scholar = User.where("id = ?", conversation.starter).take
        end
        @messages = Message.where("conversation_id = ?", conversation.id)
      else
  			render text: "error"
  		end
  end

	def create_conversation
		starter_id = session[:user_id]
		target_id = params[:target_id]
    session[:target_id] = target_id
    conversation = Conversation.where("starter = ? AND target = ?", starter_id, target_id).take
    if conversation == nil
      conversation = Conversation.where("starter = ? AND target = ?", target_id, starter_id).take
    end
		if conversation == nil
			con = Conversation.new
			con.starter = starter_id
			con.target = target_id
			con.save
		end
    redirect_to :action => "index", :target_id => target_id    
	end

  def send_message
    message = Message.new
    conversation = Conversation.where("starter = ? AND target = ?", session[:user_id], session[:target_id]).take
    if conversation == nil
      conversation = Conversation.where("starter = ? AND target = ?", session[:target_id], session[:user_id]).take
    end
    message.conversation_id = conversation.id
    message.sender_id = session[:user_id]
    message.message_text = params[:message]
    message.save
    @scholars = User.where("id != ? AND usertype = ?", session[:user_id], 'scholar')
    conversation = Conversation.where("starter = ? OR target = ?", session[:user_id], session[:user_id]).take
    if conversation.starter == session[:user_id]
      @second_scholar = User.where("id = ?", conversation.target).take
    else
      @second_scholar = User.where("id = ?", conversation.starter).take
    end
    @messages = Message.where("conversation_id = ?", conversation.id)
    render :partial => "conversations/message"
  end

  def refresh
    @scholars = User.where("id != ? AND usertype = ?", session[:user_id], 'scholar')
    conversation = Conversation.where("starter = ? AND target = ?", session[:user_id], session[:target_id]).take
    if conversation == nil
      conversation = Conversation.where("starter = ? AND target = ?", session[:target_id], session[:user_id]).take
    end
    if conversation.starter == session[:user_id]
      @second_scholar = User.where("id = ?", conversation.target).take
    else
      @second_scholar = User.where("id = ?", conversation.starter).take
    end
    @messages = Message.where("conversation_id = ?", conversation.id)
    render :partial => "conversations/message"
  end
end
