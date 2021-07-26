# frozen_string_literal: true

class RepositoryForm
  attr_reader :repository, :errors
  attr_accessor :owner, :name, :full_name

  def initialize(full_name:)
    @full_name = full_name
    @owner, @name = full_name.split('/')
    @errors = ActiveModel::Errors.new(self)
  end

  def create
    @repository = Repository.create(full_name: full_name, owner: owner, name: name)
  end

  def valid?
    validate!
    errors.blank?
  end

  def validate!
    errors.add(:owner, :blank, message: 'cannot be blank') if owner.blank?
    errors.add(:name, :blank, message: 'cannot be blank') if name.blank?
  end
end
