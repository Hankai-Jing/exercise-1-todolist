class TodolistItemsController < ApplicationController
    before_action :set_todolist_item, only: [:show, :update, :destroy]

    def show
        respond_to do |format|
            format.json { render json: @todolist_item }
        end
    end

    def update
        @todolist_item.update!(todolist_item_params)
        respond_to do |format|
            format.json { render :show, location: @todolist_item }
        end
    end

    def destroy
        @todolist_item.destroy!
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
