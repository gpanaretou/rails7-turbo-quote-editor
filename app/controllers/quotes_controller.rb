class QuotesController < ApplicationController
    before_action :set_quotes, only: [:show, :edit, :update, :destroy]

    def index
        @quotes = Quote.all
    end

    def show
    end

    def new 
        @quote = Quote.new
    end

    def create 
        @quote = Quote.new(quote_params)

        if @quote.save
            redirecto_to quotes_path, noticke: "Quote was successfully created."
        else 
            render :new
        end
    end

    def edit
    end

    def update
        if @quote.update(quote_params)
            redirecto_to quotes_path, notice: "Quote was successfully updated"
        else
            render :edit
        end
    end

    def destroy 
        @quote.destroy
        redirecto_to quotes_path, notice: "Quote was successfully destroyed."
    end

    private 

    def set_quote
        @quote = Quote.find(params[:id])
    end

    def quote_params
        params.require(:quote).permit(:name)
    end
        
end
