class TodolistItemsController < ApplicationController
    before_action :set_todolist_item, only: [:show, :update, :destroy]

    def index
        @todolist_items = TodolistItem.all
    end

    def show
        respond_to do |format|
            format.json { render json: @todolist_item }
        end
    end

    def update
        respond_to do |format|
            if @todolist_item.update(todolist_item_params)
                format.json { render :show, status: :ok, json: @todolist_item }
            else
                format.json { render json: @todolist_item.errors, status: :unprocessable_entit }
            end
        end
    end

    def destroy
        @todolist_item.destroy!
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    def create
        @todolist_item = TodolistItem.create!(todolist_item_params)
        respond_to do |format|
            format.json { render :show, status: :created, json: @todolist_item }
        end
    end

    private
    def set_todolist_item
        @todolist_item = TodolistItem.find(params[:id])
    end

    def todolist_item_params
        params.require(:todolist_item).permit(:content, :completed, :removed)
    end
end
