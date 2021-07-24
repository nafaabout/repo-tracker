class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def create
    repo_form = RepositoryForm.new(full_name: repo_params[:full_name])

    if repo_form.valid?
      @repository = repo_form.create

      redirect_to repositories_path
    else
      render new_repository
    end
  end


  private

  def repo_params
    params.require(:repository).permit(:full_name)
  end
end
