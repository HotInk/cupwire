class Article < HyperactiveResource
  belongs_to :account, :nested => true

  self.columns = [ :title, :subtitle, :authors_list, :bodytext, :summary, :created_at]

end