class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except:[:create]
	def create		
		@todo_item = @todo_list.todo_items.create(params_todo_item)
		redirect_to @todo_list
	end

	def destroy
		if @todo_item.destroy
			flash[:success] = "TODO DELETED"
		else
			flash[:error] = "ERROR"
		render todo_list_path(@todo_list)
		end	
		redirect_to @todo_list
	end

	def complete
		@todo_item.update_attribute(:completed_at, Time.now)	
		redirect_to @todo_list, notice: "Todo completed"
	end

	private
	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
 	end	

	def params_todo_item
		params[:todo_item].permit(:content)
	end

end
