class Article < HyperactiveResource
  belongs_to :account, :nested => true

end