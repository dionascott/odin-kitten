class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens.to_json }
    end
  end

  def show
    if @kitten = Kitten.find_by_id(params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @kitten.to_json }
      end
    else
      flash[:alert] = "No kitten found"
      redirect_to root_path
    end
  end

  def new
    @kitten = Kitten.new
    initialize_processor
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten created."
      redirect_to kitten_path(@kitten)
    else
      flash.now[:error] = "Wrong parameters"
      initialize_processor
      render 'new'
    end
  end

  def edit
    @kitten = Kitten.find_by_id(params[:id])
    initialize_processor
  end

  def update
    @kitten = Kitten.find_by_id(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = "Kitten updated."
      redirect_to kitten_path(@kitten)
    else
      flash.now[:error] = "Wrong parameters"
      initialize_processor
      render 'edit'
    end
  end

  def destroy
    if @kitten = Kitten.find_by_id(params[:id])
      flash[:success] = "#{@kitten.name} deleted."
      @kitten.destroy
      redirect_to root_path
    else
      flash[:alert] = "Kitten not found"
      redirect_to root_path
    end
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end

    def initialize_processor
      @cuteness = %w[adorable cute amazing].map { |x| [ x, x ] }
      @softness = %w[cuddlable super-soft very].map { |x| [ x, x ] }
    end

end
